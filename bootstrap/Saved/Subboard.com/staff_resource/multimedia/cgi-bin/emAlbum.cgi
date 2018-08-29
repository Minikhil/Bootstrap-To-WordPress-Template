#!/usr/bin/perl

###########################################
# emAlbum.cgi v2.1 - Thumbnail Mod 2      #
#=========================================#
# emAlbum v2.1                            #
# Standard Edition                        #
#-----------------------------------------#
# First Created: 2/17/03                  #
# Last Updated: 9/03/03                   #
#-----------------------------------------#
# Written by: Eric Martin                 #
# http://www.emalbum.com                  # 
#-----------------------------------------#
# Copyright (c) 2003 emAlbum.com          # 
# All Rights Reserved                     #
########################################### 

##############################################################################
# Copyright and Licensing Information                                        # 
#============================================================================#
# A copy of the License Agreement was included in this download as           #
# license.html. A copy can also be found on http://www.emalbum.com/.         #
#                                                                            #
# By installing this software, you agree to its terms. All Copyright and     #
# Licensing information must remain intact. Please contact us with any       #
# questions at support@emalbum.com.                                          #
##############################################################################

#---------------------------- DO NOT EDIT ------------------------------#
#             All setting are made in the settings.cfg file             #

use CGI::Carp qw(fatalsToBrowser);

print "Content-type: text/html\n\n";

if ($^O =~ /win/i) { $slash = "\\"; } 
else { $slash = "/"; }

$cgi_path = $ENV{'PATH_TRANSLATED'} || $ENV{'SCRIPT_FILENAME'};
$cgi_path =~ s/emAlbum.cgi//;

# Open config file
my $config_file = $cgi_path."emAlbum".$slash."settings.cfg";
require "$config_file";

# Open language file
my $language_file = $cgi_path."emAlbum".$slash."language".$slash.$language;
require "$language_file";

# Verify template file exists
my $template_path = $cgi_path."emAlbum".$slash."templates".$slash.$template.".html";
unless (-e $template_path) { &error("100|$template_path"); }

# Determine necessary variables
$image_url .= "/$template";
if ($cgi_index == 1) {
	$cgi_url = $url;
} else {
	$cgi_url .= "/emAlbum.cgi";

}

$main_link = $album_url;
$main_link =~ s/.*\///g;
$main_link = ucfirst($main_link);

# Parse query string and assign values
if (($ENV{'REQUEST_METHOD'} eq 'GET') && ($ENV{'QUERY_STRING'} ne "")) {
	@pairs = split(/&/, $ENV{'QUERY_STRING'});
	foreach $pair (@pairs) {
	   ($name, $value) = split(/=/, $pair);
	   $value =~ s/%([a-fA-F0-9][a-fA-F0-9])/pack("C", hex($1))/eg;
	   $emAlbum{$name} = $value;

	}

} else {
	$emAlbum{'cmd'} = "default";

}

# Home page link variable
if ($home == 1) { 
	$home_link = qq~<a href="$home_url" class="nav">$home_text</a> $text{'8'} ~; 

} else { 
	$home_link = ""; 

}

# Determine action to take
if (($emAlbum{'cmd'} eq "default") || ($emAlbum{'cmd'} eq "show_sub")) {
	&show_folders;

} elsif (($emAlbum{'cmd'} eq "show_image")) {
	&show_image;

} elsif (($emAlbum{'cmd'} eq "show_thumbs")) {
	&show_thumbs;

} elsif (($emAlbum{'cmd'} eq "slide_show")) {
	&slide_show;

} else {
	# Display main page if action cannot be determined
	$emAlbum{'cmd'} = "default";
	&show_folders;

}

sub show_folders {
	# Set needed variables
	$now = time;
	$total_albums = 0;
	if ($emAlbum{'cmd'} eq "show_sub") {
		$album_path = "$album_path$slash$emAlbum{'path'}";
	}

	# Open directory and read it's contents
	opendir(TMP,"$album_path") || &error("102|$album_path");
	my @contents = grep !/\./ && !/^_/ && !/$thumbs_path/, sort readdir(TMP);
	closedir(TMP);

	my $folder_count = @contents;
	if ($folder_count == 0) { &error("103|$album_path"); }

	# Set values if not present
	unless ($emAlbum{'tn'}) {
		$emAlbum{'tn'} = $use_thumbs;

	}

	foreach $sub_folder (@contents) {
		chomp $sub_folder;
		$contains_sub = 0;
		$folder_path = "$album_path$slash$sub_folder";

		# Use updated function routine
		if ($use_update == 1) {
			($dev, $ino, $mode, $nlink, $uid, $gid, $rdev, 
				$size, $atime, $mtime, $ctime, 
				$blksize, $blocks) = stat($folder_path);

			$offset = $update_range * 86400;
			$earliest = $now - $offset;

			if (($mtime|$ctime) >= $earliest) {
				$updated = 1;

			} else {
				$updated = 0;

			}

		} else {
			$updated = 0;

		}

		# Actions to take based on cmd
		if ($emAlbum{'cmd'} eq "show_sub") {
			$image_folder_path = "$album_path$slash$sub_folder";

			&img_cnt;

			$sub_details = "$emAlbum{'path'}$slash$sub_folder|$contains_sub|$folder_count|$image_count|$updated";
			push (@main,$sub_details);
			$curr_folder = $emAlbum{'path'};
			$curr_folder =~ s/_/ /g;
			$emAlbumNavigation = qq~$home_link<a href="$cgi_url" class="nav">$main_link</a> $text{'8'} $curr_folder $text{'8'}~;
			$totals_text = "$text{'11'} <b>$folder_count</b> $text{'13'} $text{'12'} <b>$total_image_count</b>";

		} else {
			&subchk;

			$details = "$sub_folder|$contains_sub|$count|$image_count|$updated";
			push (@main,$details);
			$emAlbumNavigation = qq~$home_link$main_link $text{'8'}~;
			$totals_text = "$text{'11'} <b>$total_albums</b> $text{'13'} $text{'12'} <b>$total_image_count</b>";

		}

	}

	@contents = ();

	$album_count = 0;
	$alb_cnt = @main;
	$album_rows = $alb_cnt / 2;

	$emAlbumMain = qq~
			  <tr>
			    <td colspan="3" height="10"></td>
			  </tr>~;

	# Guts of the album page
	until ($album_count >= $alb_cnt) {
		$next_album = $album_count + 1;
		$current = @main[$album_count];
		$next = @main[$next_album];

		# Current image routine
		if ($current ne "") { 
			($current_fldr,$current_contains_sub,$current_folder_count,$current_image_count,$current_updated) = split(/\|/,$current);
			chomp $current_image_count;

			if ($current_fldr =~ /\//) {
				($current_main_folder,$current_folder) = split(/\//,$current_fldr);

			} elsif ($current_fldr =~ /\\/) {
				($current_main_folder,$current_folder) = split(/\\/,$current_fldr);

			} else {
				$current_folder = $current_fldr;

			}

			if ($emAlbum{'cmd'} eq "show_sub") {
				$current_path = "$emAlbum{'path'}$slash$current_folder";

			} else {
				$current_path = $current_folder;

			}

			if ($current_updated == 1) {
				$suffix = "_new";
				$current_alt = "$text{'18'}";

			} else {
				$suffix = "";
				$current_alt = "";

			}

			$current_folder_name = $current_folder;
			$current_folder_name =~ s/\_/ /g;

			if ($current_contains_sub == 1) { 
				$current_info = "$text{'2'} $current_folder_count";
				$current_image = qq~<a href="$cgi_url?cmd=show_sub&path=$current_path&tn=$emAlbum{'tn'}"><img src="$image_url/album$suffix.gif" alt="$current_alt" border="0"></a>~;
				$current_link = qq~<a href="$cgi_url?cmd=show_sub&path=$current_path&tn=$emAlbum{'tn'}" class="album">$current_folder_name</a>~;

			} else { 
				$current_info = "$text{'3'} $current_image_count"; 
				if ($current_image_count == 0) {
					$current_image = qq~<img src="$image_url/image$suffix.gif" alt="$current_alt" border="0">~;	
					$current_link = qq~$current_folder_name~;
				
				} else {
					if ($emAlbum{'tn'} == 0) {
						$current_image = qq~<a href="$cgi_url?cmd=show_image&path=$current_path&tn=$emAlbum{'tn'}"><img src="$image_url/image$suffix.gif" alt="$current_alt" border="0"></a>~;	
						$current_link = qq~<a href="$cgi_url?cmd=show_image&path=$current_path&tn=$emAlbum{'tn'}" class="album">$current_folder_name</a>~;

					} else {
						$current_image = qq~<a href="$cgi_url?cmd=show_thumbs&path=$current_path&tn=$emAlbum{'tn'}"><img src="$image_url/image$suffix.gif" alt="$current_alt" border="0"></a>~;	
						$current_link = qq~<a href="$cgi_url?cmd=show_thumbs&path=$current_path&tn=$emAlbum{'tn'}" class="album">$current_folder_name</a>~;
					
					}

				}

			}

		} else {
			$current_info = "";
			$current_link = "";
			$current_image = "";
			
		}
		
		# Next image routine
		if ($next ne "") { 
			($next_fldr,$next_contains_sub,$next_folder_count,$next_image_count,$next_updated) = split(/\|/,$next);
			chomp $next_image_count;

			if ($next_fldr =~ /\//) {
				($next_main_folder,$next_folder) = split(/\//,$next_fldr);

			} elsif ($next_fldr =~ /\\/) {
				($next_main_folder,$next_folder) = split(/\\/,$next_fldr);

			} else {
				$next_folder = $next_fldr;

			}

			if ($emAlbum{'cmd'} eq "show_sub") {
				$next_path = "$emAlbum{'path'}$slash$next_folder";

			} else {
				$next_path = $next_folder;

			}

			if ($next_updated == 1) {
				$suffix = "_new";
				$next_alt = "$text{'18'}";

			} else {
				$suffix = "";
				$next_alt = "";

			}

			$next_folder_name = $next_folder;
			$next_folder_name =~ s/\_/ /g;

			if ($next_contains_sub == 1) { 
				$next_info = "$text{'2'} $next_folder_count";
				$next_image = qq~<a href="$cgi_url?cmd=show_sub&path=$next_path&tn=$emAlbum{'tn'}"><img src="$image_url/album$suffix.gif" alt="$next_alt" border="0"></a>~;
				$next_link = qq~<a href="$cgi_url?cmd=show_sub&path=$next_path&tn=$emAlbum{'tn'}" class="album">$next_folder_name</a>~;

			} else { 
				$next_info = "$text{'3'} $next_image_count"; 
				if ($next_image_count == 0) {
					$next_image = qq~<img src="$image_url/image$suffix.gif" alt="$next_alt" border="0">~;	
					$next_link = qq~$next_folder_name~;

				} else {
					if ($emAlbum{'tn'} == 0) {
						$next_image = qq~<a href="$cgi_url?cmd=show_image&path=$next_path&tn=$emAlbum{'tn'}"><img src="$image_url/image$suffix.gif" alt="$next_alt" border="0"></a>~;	
						$next_link = qq~<a href="$cgi_url?cmd=show_image&path=$next_path&tn=$emAlbum{'tn'}" class="album">$next_folder_name</a>~;

					} else {
						$next_image = qq~<a href="$cgi_url?cmd=show_thumbs&path=$next_path&tn=$emAlbum{'tn'}"><img src="$image_url/image$suffix.gif" alt="$next_alt" border="0"></a>~;	
						$next_link = qq~<a href="$cgi_url?cmd=show_thumbs&path=$next_path&tn=$emAlbum{'tn'}" class="album">$next_folder_name</a>~;
					
					}

				}

			}

		} else {
			$next_info = "";
			$next_link = "";
			$next_image = "";
			
		}

		# Set folder link information
		$emAlbumMain .= qq~
			  <!-- BEGIN ALBUM ROW -->
			  <tr>
				<td width="48%" valign="top">
				  <table border="0" cellpadding="0" cellspacing="0" width="100%">
					<tr valign="top">
					  <td width="12%" rowspan="3" class="icon">$current_image</td>
					  <td width="88%" class="album">$current_link</td>
					</tr>
					<tr>
					  <td width="88%" class="info">$current_info</td>
					</tr>
					<tr>
					  <td width="88%" height="10">&nbsp;</td>
					</tr>
				  </table>
				</td>
				<td width="4%"></td>
				<td width="48%" valign="top">
				  <table border="0" cellpadding="0" cellspacing="0" width="100%">
					<tr valign="top">
					  <td width="12%" rowspan="3" class="icon">$next_image</td>
					  <td width="88%" class="album">$next_link</td>
					</tr>
					<tr>
					  <td width="88%" class="info">$next_info</td></td>
					</tr>
					<tr>
					  <td width="88%" height="10">&nbsp;</td>
					</tr>
				  </table>
				</td>
			  </tr>
			  <!-- END ALBUM ROW -->~;

		$album_count = $album_count + 2;

	}

	# Set specific header information
	$emAlbumHeader = qq~
	<td width="5"></td>
	<td class="menucenter">$totals_text</td>
	<td width="5"></td>~;

	# Set specific footer information
	$emAlbumFooter = qq~
	<td width="5" class="footer"></td>
	<td width="*" class="footer">&nbsp;</td>
	<td width="5" class="footer"></td>~;

	# Finish up and display page
	&html;

}

sub subchk  {
	# Open the directory and count the valid sub-folders
	opendir(TMP,"$folder_path") || &error("104|$folder_path");
	my @sub_contents = grep !/\./ && !/^_/ && !/$thumbs_path/, sort readdir(TMP);
	closedir(TMP);
	$count = @sub_contents;

	# If there are sub-folders set needed variables and continue
	if ($count != 0) {
		$contains_sub = 1;
		$image_count = 0;
		$total_albums += $count;

		foreach $line (@sub_contents) {
			chomp $line;
			$image_folder_path = "$folder_path$slash$line";
			&img_cnt;

		}

	} else {
		$total_albums++;
		$image_folder_path = $folder_path;
		&img_cnt;

	}

}

sub img_cnt {
	# Open the image directory and count the valid images
	opendir(IMG,"$image_folder_path") || &error("105|$image_folder_path");
	my @valid_images = grep /\.(jpg|jpeg|jpe|bmp|gif|png|tiff|tif)$/i, sort readdir(IMG);
	closedir(IMG);
	$image_count = @valid_images;

	$total_image_count += $image_count;
	
	@valid_images = ();

}

sub show_image {
	my $image_path = "$album_path$slash$emAlbum{'path'}";
	# Open the image directory and get the selected image
	opendir(SHI,"$image_path") || &error("107|$image_path");
	my @images = grep /\.(jpg|jpeg|jpe|bmp|gif|png|tiff|tif)$/i, sort readdir(SHI);
	closedir(SHI);	

	my $display_number = $emAlbum{'img'} + 1;
	unless ($emAlbum{'img'}) {
		$emAlbum{'img'} = 0;
		$display_number = 1;
	
	}

	unless ($emAlbum{'tn'}) {
		$emAlbum{'tn'} = $use_thumbs;

	}

	my $display_image = @images[$emAlbum{'img'}];
	my $image_src = qq~<img border="2" src="$album_url/$emAlbum{'path'}/$display_image" class="imgborder" alt="$text{'1'}">~;
	my $display_name = $display_image;
	my $total_images = @images;
	if ($total_images == 0 ) { &error("108|$total_images"); }
	
	$thumb_link = "";
	if ($emAlbum{'tn'} == 1) {
		$thumb_link = qq~$cgi_url?cmd=show_thumbs&path=$emAlbum{'path'}&tn=$emAlbum{'tn'}~;
	
	}

	if ($caption == 0) { $display_name = ""; }
	elsif ($caption == 2) { $display_name =~ s/\_/ /g; $display_name =~ s/\.(jpg|jpeg|jpe|bmp|gif|png|tiff|tif)$//i; }

	if ($emAlbum{'path'} =~ /\//) {
		($main_folder,$folder) = split(/\//,$emAlbum{'path'});
		$folder_name = $folder;
		$folder_name =~ s/\_/ /g;
		$main_folder_name = $main_folder;
		$main_folder_name =~ s/\_/ /g;
		if ($emAlbum{'tn'} == 1) {
			$emAlbumNavigation = qq~$home_link<a href="$cgi_url" class="nav">$main_link</a> $text{'8'} <a href="$cgi_url?cmd=show_sub&path=$main_folder&tn=$emAlbum{'tn'}" class="nav">$main_folder_name</a> $text{'8'} <a href="$thumb_link">$folder_name</a> $text{'8'}~;

		} else {
			$emAlbumNavigation = qq~$home_link<a href="$cgi_url" class="nav">$main_link</a> $text{'8'} <a href="$cgi_url?cmd=show_sub&path=$main_folder&tn=$emAlbum{'tn'}" class="nav">$main_folder_name</a> $text{'8'} $folder_name $text{'8'}~;

		}

		
	} elsif ($emAlbum{'path'} =~ /\\/) {
		($main_folder,$folder) = split(/\\/,$emAlbum{'path'});
		$folder_name = $folder;
		$folder_name =~ s/\_/ /g;
		$main_folder_name = $main_folder;
		$main_folder_name =~ s/\_/ /g;
		if ($emAlbum{'tn'} == 1) {
			$emAlbumNavigation = qq~$home_link<a href="$cgi_url" class="nav">$main_link</a> $text{'8'} <a href="$cgi_url?cmd=show_sub&path=$main_folder&tn=$emAlbum{'tn'}" class="nav">$main_folder_name</a> $text{'8'} <a href="$thumb_link">$folder_name</a> $text{'8'}~;

		} else{
			$emAlbumNavigation = qq~$home_link<a href="$cgi_url" class="nav">$main_link</a> $text{'8'} <a href="$cgi_url?cmd=show_sub&path=$main_folder&tn=$emAlbum{'tn'}" class="nav">$main_folder_name</a> $text{'8'} $folder_name $text{'8'}~;

		}
		
	} else {
		$folder = $emAlbum{'path'};
		$folder_name = $folder;
		$folder_name =~ s/\_/ /g;
		if ($emAlbum{'tn'} == 1) {
			$emAlbumNavigation = qq~$home_link<a href="$cgi_url" class="nav">$main_link</a> $text{'8'} <a href="$thumb_link" class="nav">$folder_name</a> $text{'8'}~;

		} else {
			$emAlbumNavigation = qq~$home_link<a href="$cgi_url" class="nav">$main_link</a> $text{'8'} $folder_name $text{'8'}~;

		}

	}

	my $image_link = "$text{'16'} ";
	
	if ($total_images == 1) { 
		$image_link .= qq~<b><img src="$image_url/prev_none.gif" border="0" alt=""> [$display_number] </b><img src="$image_url/next_none.gif" border="0" alt="">~; 

	} elsif (($total_images > 1) && ($total_images < 9)) {
		my $image_count = 0;
		if ($emAlbum{'img'} != 0) { 
			my $prev_image = $emAlbum{'img'} - 1;
			$image_link .= qq~<a href="$cgi_url?cmd=show_image&path=$emAlbum{'path'}&img=$prev_image&tn=$emAlbum{'tn'}"><img src="$image_url/prev.gif" border="0" alt="$text{'9'}"></a> ~;
		
		} else {
			$image_link .= qq~<img src="$image_url/prev_none.gif" border="0" alt=""> ~;

		}
		
		until ($image_count == $total_images) {
			my $display_number = $image_count + 1;
			if ($image_count == $emAlbum{'img'}) {
				$image_link .= qq~<b>[$display_number]</b> ~;

			} else {
				$image_link .= qq~<a href="$cgi_url?cmd=show_image&path=$emAlbum{'path'}&img=$image_count&tn=$emAlbum{'tn'}">$display_number</a> ~;

			}

		$image_count++;

		}
	
		my $display_number = $emAlbum{'img'} + 1;
		if ($display_number == $total_images) {
			$image_link .= qq~<img src="$image_url/next_none.gif" border="0" alt="">~;

		} else {
			$image_link .= qq~<a href="$cgi_url?cmd=show_image&path=$emAlbum{'path'}&img=$display_number&tn=$emAlbum{'tn'}"><img src="$image_url/next.gif" border="0" alt="$text{'10'}"></a>~;

		}

	} elsif ($total_images >= 9) {
		my $end_image = $emAlbum{'img'} + 3;
		my $beg_image = $emAlbum{'img'} - 1;
		my $start = $total_images - 4;
		my $display_number = $emAlbum{'img'} + 1;

		if ($emAlbum{'img'} == 0) {
			my $display_number = $emAlbum{'img'} + 1;
			$image_link .= qq~<img src="$image_url/prev_none.gif" border="0" alt=""> <b>[$display_number]</b> ~;
			$image_count = 2;

			until ($image_count > 3) {
				my $next_image = $image_count - 1;
				$image_link .= qq~<a href="$cgi_url?cmd=show_image&path=$emAlbum{'path'}&img=$next_image&tn=$emAlbum{'tn'}">$image_count</a> ~;
				$image_count++;
			
			}

			my $last_image = $total_images - 1;
			$image_link .= qq~... <a href="$cgi_url?cmd=show_image&path=$emAlbum{'path'}&img=$last_image&tn=$emAlbum{'tn'}">$total_images</a> ~;
			my $next_image = $emAlbum{'img'} + 1;
			$image_link .= qq~<a href="$cgi_url?cmd=show_image&path=$emAlbum{'path'}&img=$next_image&tn=$emAlbum{'tn'}"><img src="$image_url/next.gif" border="0" alt="$text{'10'}"></a>~;
		
		} elsif (($emAlbum{'img'} > 0) && ($emAlbum{'img'} < 4)) {
			my $prev_image = $emAlbum{'img'} - 1;
			$image_link .= qq~<a href="$cgi_url?cmd=show_image&path=$emAlbum{'path'}&img=$prev_image&tn=$emAlbum{'tn'}"><img src="$image_url/prev.gif" border="0" alt="$text{'9'}"></a> ~;
			$image_link .= qq~<a href="$cgi_url?cmd=show_image&path=$emAlbum{'path'}&img=0&tn=$emAlbum{'tn'}">1</a> ~;
			$image_count = 2;

			until ($image_count > $end_image) {
				$display_number = $emAlbum{'img'} + 1;
				if ($display_number == $image_count) {
					$image_link .= qq~<b>[$display_number]</b> ~;
				
				} else {
					my $next_image = $image_count - 1;
					$image_link .= qq~<a href="$cgi_url?cmd=show_image&path=$emAlbum{'path'}&img=$next_image&tn=$emAlbum{'tn'}">$image_count</a> ~;
				
				}

				$image_count++;
			
			}

			my $last_image = $total_images - 1;
			$image_link .= qq~... <a href="$cgi_url?cmd=show_image&path=$emAlbum{'path'}&img=$last_image&tn=$emAlbum{'tn'}">$total_images</a> ~;
			my $next_image = $emAlbum{'img'} + 1;
			$image_link .= qq~<a href="$cgi_url?cmd=show_image&path=$emAlbum{'path'}&img=$next_image&tn=$emAlbum{'tn'}"><img src="$image_url/next.gif" border="0" alt="$text{'10'}"></a>~;
		
		} elsif (($emAlbum{'img'} >= 4) && ($emAlbum{'img'} < $start)) {
			my $prev_image = $emAlbum{'img'} - 1;
			$image_link .= qq~<a href="$cgi_url?cmd=show_image&path=$emAlbum{'path'}&img=$prev_image&tn=$emAlbum{'tn'}"><img src="$image_url/prev.gif" border="0" alt="$text{'9'}"></a> ~;
			$image_link .= qq~<a href="$cgi_url?cmd=show_image&path=$emAlbum{'path'}&img=0&tn=$emAlbum{'tn'}">1</a> ... ~;
			$image_count = $beg_image;

			until ($image_count > $end_image) {
				my $display_number = $emAlbum{'img'} + 1;
				if ($display_number == $image_count) {
					$image_link .= qq~<b>[$display_number]</b> ~;

				} else {
					my $next_image = $image_count -1;
					$image_link .= qq~<a href="$cgi_url?cmd=show_image&path=$emAlbum{'path'}&img=$next_image&tn=$emAlbum{'tn'}">$image_count</a> ~;
				
				}

				$image_count++;

			}

			my $last_image = $total_images - 1;
			$image_link .= qq~... <a href="$cgi_url?cmd=show_image&path=$emAlbum{'path'}&img=$last_image&tn=$emAlbum{'tn'}">$total_images</a> ~;
			my $next_image = $emAlbum{'img'} + 1;
			$image_link .= qq~<a href="$cgi_url?cmd=show_image&path=$emAlbum{'path'}&img=$next_image&tn=$emAlbum{'tn'}"><img src="$image_url/next.gif" border="0" alt="$text{'10'}"></a>~;

		} elsif (($emAlbum{'img'} >= $start) && ($emAlbum{'img'} < $total_images)) {
			my $prev_image = $emAlbum{'img'} - 1;
			$image_link .= qq~<a href="$cgi_url?cmd=show_image&path=$emAlbum{'path'}&img=$prev_image&tn=$emAlbum{'tn'}"><img src="$image_url/prev.gif" border="0" alt="$text{'9'}"></a> ~;
			$image_link .= qq~<a href="$cgi_url?cmd=show_image&path=$emAlbum{'path'}&img=0&tn=$emAlbum{'tn'}">1</a> ... ~;
			$image_count = $beg_image;

			until ($image_count == $total_images) {
				my $display_number = $emAlbum{'img'} + 1;
				if ($display_number == $image_count) {
					$image_link .= qq~<b>[$display_number]</b> ~;
				
				} else {
					my $next_image = $image_count - 1;
					$image_link .= qq~<a href="$cgi_url?cmd=show_image&path=$emAlbum{'path'}&img=$next_image&tn=$emAlbum{'tn'}">$image_count</a> ~;
				
				}

				$image_count++;

			}

			my $display_number = $emAlbum{'img'} + 1;
			if ($display_number == $total_images) {
				$image_link .= qq~<b>[$display_number]</b> <img src="$image_url/next_none.gif" border="0" alt="">~;

			} else {
				my $next_image = $total_images - 1;
				$image_link .= qq~<a href="$cgi_url?cmd=show_image&path=$emAlbum{'path'}&img=$next_image&tn=$emAlbum{'tn'}">$total_images</a> ~;
				my $next_image = $emAlbum{'img'} + 1;
				$image_link .= qq~<a href="$cgi_url?cmd=show_image&path=$emAlbum{'path'}&img=$next_image&tn=$emAlbum{'tn'}"><img src="$image_url/next.gif" border="0" alt="$text{'10'}"></a>~;

			}
		
		} elsif ($display_number == $total_images) {
			my $prev_image = $emAlbum{'img'} - 1;
			$image_link .= qq~<a href="$cgi_url?cmd=show_image&path=$emAlbum{'path'}&img=$prev_image&tn=$emAlbum{'tn'}"><img src="$image_url/prev.gif" border="0" alt="$text{'9'}"></a> ~;
			$image_link .= qq~<a href="$cgi_url?cmd=show_image&path=$emAlbum{'path'}&img=0&tn=$emAlbum{'tn'}">1</a> ... ~;
			$image_count = $total_images - 2;

			until ($image_count == $total_images) {
				my $next_image = $emAlbum{'img'} + 1;
				$image_link .= qq~<a href="">$image_count</a> ~;
				$image_count++;
			
			}

			$image_link .= qq~<b>[$emAlbum{'img'}]</b> <img src="$image_url/next_none.gif" border="0" alt="">~;
		
		}

	}

	if (($use_thumbs == 0) && ($drop == 1)) {
		$drop_code = qq~
		  	  <tr>
			    <td class="drop">
				  <select name="jump" onChange="location.href='$cgi_url?cmd=show_image&path=$emAlbum{'path'}&img='+ document.image.jump.value +'&tn=$emAlbum{'tn'}'">
				  <option selected value="0">$text{'33'}</option>~;
		
		$cnt = 0;
		foreach (@images) {
			$drop_name = $_;
			if ($caption == 0) { $drop_name = $cnt + 1; }
			elsif ($caption == 2) { $drop_name =~ s/\_/ /g; $drop_name =~ s/\.(jpg|jpeg|jpe|bmp|gif|png|tiff|tif)$//i; }

			$drop_code .= qq~
				  <option value="$cnt">- $drop_name</option>~;

			$cnt++;
			
		}

		$drop_code .= qq~
				  </select>
			    </td>
			  </tr>
			  <tr>
				<td height="10"></td>
			  </tr>~;

		$tdh = 5;

	} else { $tdh = 10; }

	$emAlbumMain = qq~
			  <form name="image">
			  <tr>
				<td height="10"></td>
			  </tr>
			  $drop_code
			  <tr>
				<td align="center" width="100%">
				  <!-- IMAGE -->
				  <table border="0" cellpadding="0" cellspacing="0" width="100%" class="displayimage">
					<tr>
					  <td rowspan="5"><img src="$image_url/trans.gif" border="0" width="10"></td>
					  <td height="15"></td>
					  <td rowspan="5"><img src="$image_url/trans.gif" border="0" width="10"></td>
					</tr>
					<tr>
					  <td class="image">$image_src</td>
					</tr>
					<tr>
					  <td height="5"></td>
					</tr>
					<tr>
					  <td class="caption">$display_name</td>
					</tr>
					<tr>
					  <td height="10"></td>
					</tr>
				  </table>
				</td>
			  </tr>
			  <tr>
				<td height="10"></td>
			  </tr>
			  </form>~;

	if ($slide_show == 1) {
		$slide_link = qq~<a href="$cgi_url?cmd=slide_show&action=play&speed=$default_speed&path=$emAlbum{'path'}&img=$emAlbum{'img'}&tn=$emAlbum{'tn'}" title="$text{'31'}">$text{'32'}</a>~;
		$slide_link .= qq~ <a href="$cgi_url?cmd=slide_show&action=play&speed=$default_speed&path=$emAlbum{'path'}&img=$emAlbum{'img'}&tn=$emAlbum{'tn'}">~;
		$slide_link .= qq~<img src="$image_url/slide.gif" border="0" align="absmiddle" alt="$text{'31'}"></a>~;
	
	} else {
		$slide_link = "";

	}

	$emAlbumHeader = qq~
	<td width="10"></td>
	<td width="25%" class="menuleft">$text{'14'} <b>$display_number</b> $text{'15'} <b>$total_images</b></td>
	<td width="*%" class="menucenter">$image_link</td>
	<td width="25%" class="menuright">$slide_link</td>
	<td width="10"></td>~;

	$emAlbumFooter = qq~
	<td width="5" class="footer"></td>
	<td width="*" class="footer">&nbsp;</td>
	<td width="5" class="footer"></td>~;

	&html;

}

sub show_thumbs {
	# Check for variables, set if not declared
	unless ($emAlbum{'img'}) { $emAlbum{'img'} = 0; }
	unless ($emAlbum{'page'}) { $emAlbum{'page'} = 1; }

	$image_number = $emAlbum{'img'};

	# Open image directory and put all valid images into an array
	my $thumb_image_path = "$album_path$slash$emAlbum{'path'}";
	opendir(IPH,$thumb_image_path) || &error("109|$thumb_image_path");
	my @images = grep /\.(jpg|jpeg|jpe|bmp|gif|png|tiff|tif)$/i, sort readdir(IPH);
	closedir(IPH);

	# Split the path if necessary
	if ($emAlbum{'path'} =~ /\//) {
		($main_folder,$folder) = split(/\//,$emAlbum{'path'});
		$folder_name = $folder;
		$folder_name =~ s/\_/ /g;
		$main_folder_name = $main_folder;
		$main_folder_name =~ s/\_/ /g;
		$emAlbumNavigation = qq~$home_link<a href="$cgi_url" class="nav">$main_link</a> $text{'8'} <a href="$cgi_url?cmd=show_sub&path=$main_folder&tn=$emAlbum{'tn'}" class="nav">$main_folder_name</a> $text{'8'} $folder_name $text{'8'}~;

	} elsif ($emAlbum{'path'} =~ /\\/) {
		($main_folder,$folder) = split(/\\/,$emAlbum{'path'});
		$folder_name = $folder;
		$folder_name =~ s/\_/ /g;
		$main_folder_name = $main_folder;
		$main_folder_name =~ s/\_/ /g;
		$emAlbumNavigation = qq~$home_link<a href="$cgi_url" class="nav">$main_link</a> $text{'8'} <a href="$cgi_url?cmd=show_sub&path=$main_folder&tn=$emAlbum{'tn'}" class="nav">$main_folder_name</a> $text{'8'} $folder_name $text{'8'}~;

	} else {
		$folder = $emAlbum{'path'};
		$folder_name = $folder;
		$folder_name =~ s/\_/ /g;
		$emAlbumNavigation = qq~$home_link<a href="$cgi_url" class="nav">$main_link</a> $text{'8'} $folder_name $text{'8'}~;

	}

	unless ($emAlbum{'tn'}) {
		$emAlbum{'tn'} = $use_thumbs;

	}

	# Determine necessary variables
	my $total_images = @images;
	my $per_page = $per_row * $max_rows;
	my $pages_needed = $total_images / $per_page;

	# Round up
	if ($pages_needed =~ /\./) {
		$pages_needed =~ s/\..*//;
		$pages_needed++;
	}

	# Determine variables dependent on page
	if ($emAlbum{'page'} != 1) {
		$page_total = $total_images - $image_number;
		if ($page_total < $per_row) { $per_row = $page_total; }
		$rows = ($page_total) / $per_row;
	} else {
		$page_total = $total_images;
		if ($total_images < $per_row) { $per_row = $total_images; }
		$rows = ($total_images - $image_number) / $per_row;
	}

	# Round up
	if ($rows =~ /\./) {
		$rows =~ s/\..*//;
		$rows++;
	}

	# Row settings
	if ($per_row == 1) { 
		$width1 = "100%"; 
		
	} elsif ($per_row == 2) { 
		$width1 = "49%"; 
		$width2 = "*"; 
		
	} elsif ($per_row == 3) { 
		$width1 = "33%"; 
		$width2 = "33%"; 
		$width3 = "*"; 
	
	} elsif ($per_row == 4) { 
		$width1 = "24%"; 
		$width2 = "25%"; 
		$width3 = "25%"; 
		$width4 = "*"; 
		
	} elsif ($per_row == 5) { 
		$width1 = "19%"; 
		$width2 = "20%"; 
		$width3 = "20%"; 
		$width4 = "20%"; 
		$width5 = "*"; 
		
	} elsif ($per_row == 6) { 
		$width1 = "16%"; 
		$width2 = "17%"; 
		$width3 = "17%"; 
		$width4 = "17%"; 
		$width5 = "17%"; 
		$width6 = "*"; 
		
	}	

	my $show_row_count = 0;
	my $show_image_count = 0;
	my $max_count = 1;
	my $column_span = ($per_row * 2) - 1;
	my $last = $total_images - 1;

	if (($rows < $max_rows) && ($emAlbum{'page'} == 1)) {
		$max_rows = $rows;
		$pages_needed = 1;
	
	} elsif (($rows < $max_rows) && ($emAlbum{'page'} != 1)) { 
		$max_rows = $rows; 
		
	}

	my $page_link = "$text{'4'} ";
	
	if ($pages_needed == 1) { 
		$page_link .= qq~<img src="$image_url/prev_none.gif" border="0" alt=""> <b>[$emAlbum{'page'}]</b> <img src="$image_url/next_none.gif" border="0" alt="">~; 

	} elsif (($pages_needed > 1) && ($pages_needed < 9)) {
		$page_count = 1;
		
		if ($emAlbum{'page'} != 1) { 
			$prev_page = $emAlbum{'page'} - 1;
			$prev_page_image = ($emAlbum{'page'} - 2) * $per_page;
			$page_link .= qq~<a href="$cgi_url?cmd=show_thumbs&path=$emAlbum{'path'}&img=$prev_page_image&page=$prev_page&tn=$emAlbum{'tn'}"><img src="$image_url/prev.gif" border="0" alt="$text{'9'}"></a> ~;
		
		} else {
			$page_link .= qq~<img src="$image_url/prev_none.gif" border="0" alt=""> ~;

		}
		
		until ($page_count == $pages_needed) {
			if ($page_count == $emAlbum{'page'}) {
				$page_link .= qq~<b>[$page_count]</b> ~;

			} else {
				$next_page_image = ($page_count - 1) * $per_page;
				$page_link .= qq~<a href="$cgi_url?cmd=show_thumbs&path=$emAlbum{'path'}&img=$next_page_image&page=$page_count&tn=$emAlbum{'tn'}">$page_count</a> ~;

			}

		$page_count++;

		}

		if ($emAlbum{'page'} == $pages_needed) {
			$page_link .= qq~<b>[$emAlbum{'page'}]</b> <img src="$image_url/next_none.gif" border="0" alt="">~;

		} else {
			$next_page_image = ($page_count - 1) * $per_page;
			$page_link .= qq~<a href="$cgi_url?cmd=show_thumbs&path=$emAlbum{'path'}&img=$next_page_image&page=$pages_needed&tn=$emAlbum{'tn'}">$pages_needed</a> ~;
			$next_page = $emAlbum{'page'} + 1;
			$next_page_image = ($emAlbum{'page'}) * $per_page;
			$page_link .= qq~<a href="$cgi_url?cmd=show_thumbs&path=$emAlbum{'path'}&img=$next_page_image&page=$next_page&tn=$emAlbum{'tn'}"><img src="$image_url/next.gif" border="0" alt="$text{'10'}"></a>~;

		}

	} elsif ($pages_needed >= 9) {
		$end_page = $emAlbum{'page'} + 2;
		$beg_page = $emAlbum{'page'} - 2;
		$start = $pages_needed - 4;

		if ($emAlbum{'page'} == 1) {
			$page_link .= qq~<img src="$image_url/prev_none.gif" border="0" alt=""> <b>[$emAlbum{'page'}]</b> ~;
			$page_count = 2;

			until ($page_count > 3) {
				$next_page_image = ($page_count - 1) * $per_page;
				$page_link .= qq~<a href="$cgi_url?cmd=show_thumbs&path=$emAlbum{'path'}&img=$next_page_image&page=$page_count&tn=$emAlbum{'tn'}">$page_count</a> ~;
				$page_count++;
			
			}

			$next_page_image = ($pages_needed - 1) * $per_page;
			$page_link .= qq~... <a href="$cgi_url?cmd=show_thumbs&path=$emAlbum{'path'}&img=$next_page_image&page=$pages_needed&tn=$emAlbum{'tn'}">$pages_needed</a> ~;
			$next_page = $emAlbum{'page'} + 1;
			$next_page_image = ($emAlbum{'page'}) * $per_page;
			$page_link .= qq~<a href="$cgi_url?cmd=show_thumbs&path=$emAlbum{'path'}&img=$next_page_image&page=$next_page&tn=$emAlbum{'tn'}"><img src="$image_url/next.gif" border="0" alt="$text{'10'}"></a>~;
		
		} elsif (($emAlbum{'page'} > 1) && ($emAlbum{'page'} < 5)) {
			$prev_page = $emAlbum{'page'} - 1;
			$prev_page_image = ($emAlbum{'page'} - 2) * $per_page;
			$page_link .= qq~<a href="$cgi_url?cmd=show_thumbs&path=$emAlbum{'path'}&img=$prev_page_image&page=$prev_page&tn=$emAlbum{'tn'}"><img src="$image_url/prev.gif" border="0" alt="$text{'9'}"></a> ~;
			$page_link .= qq~<a href="$cgi_url?cmd=show_thumbs&path=$emAlbum{'path'}&img=0&page=1&tn=$emAlbum{'tn'}">1</a> ~;
			$page_count = 2;

			until ($page_count > $end_page) {
				if ($emAlbum{'page'} == $page_count) {
					$page_link .= qq~<b>[$emAlbum{'page'}]</b> ~;
				
				} else {
					$next_page_image = ($page_count - 1) * $per_page;
					$page_link .= qq~<a href="$cgi_url?cmd=show_thumbs&path=$emAlbum{'path'}&img=$next_page_image&page=$page_count&tn=$emAlbum{'tn'}">$page_count</a> ~;
				
				}

				$page_count++;
			
			}

			if ($emAlbum{'page'} == $pages_needed) {
				$page_link .= qq~<b>[$emAlbum{'page'}]</b> <img src="$image_url/next_none.gif" border="0" alt="">~;

			} else {
				$next_page_image = ($pages_needed - 1) * $per_page;
				$page_link .= qq~... <a href="$cgi_url?cmd=show_thumbs&path=$emAlbum{'path'}&img=$next_page_image&page=$pages_needed&tn=$emAlbum{'tn'}">$pages_needed</a> ~;
				$next_page = $emAlbum{'page'} + 1;
				$next_page_image = ($emAlbum{'page'}) * $per_page;
				$page_link .= qq~<a href="$cgi_url?cmd=show_thumbs&path=$emAlbum{'path'}&img=$next_page_image&page=$next_page&tn=$emAlbum{'tn'}"><img src="$image_url/next.gif" border="0" alt="$text{'10'}"></a>~;

			}
		
		} elsif (($emAlbum{'page'} >= 5) && ($emAlbum{'page'} <= $start)) {
			$prev_page = $emAlbum{'page'} - 1;
			$prev_page_image = ($emAlbum{'page'} - 2) * $per_page;
			$page_link .= qq~<a href="$cgi_url?cmd=show_thumbs&path=$emAlbum{'path'}&img=$prev_page_image&page=$prev_page&tn=$emAlbum{'tn'}"><img src="$image_url/prev.gif" border="0" alt="$text{'9'}"></a> ~;
			$page_link .= qq~<a href="$cgi_url?cmd=show_thumbs&path=$emAlbum{'path'}&page=1&tn=$emAlbum{'tn'}">1</a> ... ~;
			$page_count = $beg_page;

			until ($page_count > $end_page) {
				if ($emAlbum{'page'} == $page_count) {
					$page_link .= qq~<b>[$emAlbum{'page'}]</b> ~;

				} else {
					$next_page_image = ($page_count - 1) * $per_page;
					$page_link .= qq~<a href="$cgi_url?cmd=show_thumbs&path=$emAlbum{'path'}&img=$next_page_image&page=$page_count&tn=$emAlbum{'tn'}">$page_count</a> ~;
				
				}

				$page_count++;

			}

			if ($emAlbum{'page'} == $pages_needed) {
				$page_link .= qq~<b>[$emAlbum{'page'}]</b> <img src="$image_url/next_none.gif" border="0" alt="">~;

			} else {
				$next_page_image = ($pages_needed - 1) * $per_page;
				$page_link .= qq~... <a href="$cgi_url?cmd=show_thumbs&path=$emAlbum{'path'}&img=$next_page_image&page=$pages_needed&tn=$emAlbum{'tn'}">$pages_needed</a> ~;
				$next_page = $emAlbum{'page'} + 1;
				$next_page_image = ($emAlbum{'page'}) * $per_page;
				$page_link .= qq~<a href="$cgi_url?cmd=show_thumbs&path=$emAlbum{'path'}&img=$next_page_image&page=$next_page&tn=$emAlbum{'tn'}"><img src="$image_url/next.gif" border="0" alt="$text{'10'}"></a>~;

			}

		} elsif (($emAlbum{'page'} > $start) && ($emAlbum{'page'} < $pages_needed)) {
			$prev_page = $emAlbum{'page'} - 1;
			$prev_page_image = ($emAlbum{'page'} - 2) * $per_page;
			$page_link .= qq~<a href="$cgi_url?cmd=show_thumbs&path=$emAlbum{'path'}&img=$prev_page_image&page=$prev_page&tn=$emAlbum{'tn'}"><img src="$image_url/prev.gif" border="0" alt="$text{'9'}"></a> ~;
			$page_link .= qq~<a href="$cgi_url?cmd=show_thumbs&path=$emAlbum{'path'}&img=0&page=1&tn=$emAlbum{'tn'}">1</a> ... ~;
			$page_count = $beg_page;

			until ($page_count == $pages_needed) {
				if ($emAlbum{'page'} == $page_count) {
					$page_link .= qq~<b>[$emAlbum{'page'}]</b> ~;
				
				} else {
					$next_page_image = ($page_count - 1) * $per_page;
					$page_link .= qq~<a href="$cgi_url?cmd=show_thumbs&path=$emAlbum{'path'}&img=$next_page_image&page=$page_count&tn=$emAlbum{'tn'}">$page_count</a> ~;
				
				}

				$page_count++;

			}

			if ($emAlbum{'page'} == $pages_needed) {
				$page_link .= qq~<b>[$emAlbum{'page'}]</b> <img src="$image_url/next_none.gif" border="0" alt="">~;

			} else {
				$next_page_image = ($pages_needed - 1) * $per_page;
				$page_link .= qq~<a href="$cgi_url?cmd=show_thumbs&path=$emAlbum{'path'}&img=$next_page_image&page=$pages_needed&tn=$emAlbum{'tn'}">$pages_needed</a> ~;
				$next_page = $emAlbum{'page'} + 1;
				$next_page_image = ($emAlbum{'page'}) * $per_page;
				$page_link .= qq~<a href="$cgi_url?cmd=show_thumbs&path=$emAlbum{'path'}&img=$next_page_image&page=$next_page&tn=$emAlbum{'tn'}"><img src="$image_url/next.gif" border="0" alt="$text{'10'}"></a>~;

			}
		
		} elsif ($emAlbum{'page'} == $pages_needed) {
			$prev_page = $emAlbum{'page'} - 1;
			$prev_page_image = ($emAlbum{'page'} - 2) * $per_page;
			$page_link .= qq~<a href="$cgi_url?cmd=show_thumbs&path=$emAlbum{'path'}&img=$prev_page_image&page=$prev_page&tn=$emAlbum{'tn'}"><img src="$image_url/prev.gif" border="0" alt="$text{'9'}"></a> ~;
			$page_link .= qq~<a href="$cgi_url?cmd=show_thumbs&path=$emAlbum{'path'}&img=0&page=1&tn=$emAlbum{'tn'}">1</a> ... ~;
			$page_count = $pages_needed - 2;

			until ($page_count == $pages_needed) {
				$next_page_image = ($page_count - 1) * $per_page;
				$page_link .= qq~<a href="$cgi_url?cmd=show_thumbs&path=$emAlbum{'path'}&img=$next_page_image&page=$page_count&tn=$emAlbum{'tn'}">$page_count</a> ~;
				$page_count++;
			
			}

			$page_link .= qq~<b>[$emAlbum{'page'}]</b> <img src="$image_url/next_none.gif" border="0" alt="">~;
		
		}

	}

	$emAlbumMain = qq~
			  <tr>
				<td height="10"></td>
			  </tr>
			  <tr>~;


	$emAlbumHeader = qq~
		<td width="10"></td>
		<td width="33%" class="menuleft">$text{'6'} <b>$emAlbum{'page'}</b> $text{'7'} <b>$pages_needed</b></td>
		<td width="*%" class="menucenter">$page_link</td>
		<td width="33%" class="menuright">$text{'5'} <b>$total_images</b></td>
		<td width="10"></td>~;

	until ($show_row_count == $max_rows) {
		$per_cnt = 1;

		until ($show_image_count == $per_row) {
			$image = @images[$image_number];

			if ($image =~ /(tiff|tif)$/i) {
				$filetype_link = "$image_url/tifffile.gif";

			} elsif ($image =~ /(jpg|jpeg|jpe)$/i) {
				$filetype_link = "$image_url/jpegfile.gif";

			} elsif ($image =~ /bmp$/i) {
				$filetype_link = "$image_url/bmpfile.gif";

			} elsif ($image =~ /gif$/i) {
				$filetype_link = "$image_url/giffile.gif";

			} elsif ($image =~ /png$/i) {
				$filetype_link = "$image_url/pngfile.gif";

			}

			if ($thumb_extension ne "" ) {
				$image =~ s/(jpg|jpeg|jpe|bmp|gif|png|tiff|tif)$/$thumb_extension/i;

			}

			if ($thumbs_place == 0) {
				$test_thumb = "$album_path$slash$emAlbum{'path'}$slash$thumbs_path$slash$prefix$image";

				unless (-e $test_thumb) { 
					$thumb_image_url = $filetype_link;

				} else {
					$thumb_image_url = "$album_url/$emAlbum{'path'}/$thumbs_url/$prefix$image";

				}

			} else {
				$test_thumb = "$thumbs_path$slash$emAlbum{'path'}$slash$prefix$image";

				unless (-e $test_thumb) { 
					$thumb_image_url = $filetype_link;

				} else {
					$thumb_image_url = "$thumbs_url$slash$emAlbum{'path'}$slash$prefix$image";

				}

			}

			my $imageURL = qq~<img src="$thumb_image_url" border="2" class="imgborder" alt="$text{'0'}">~;

			if ($image_number >= $total_images) { 
				$imageURL = "&nbsp; "; 
				
			} else {
				if ($per_row == 1) {
					$emAlbumMain .= qq~
			<td align="center" width="$width1">~;
				} elsif (($per_row == 2) && ($per_cnt == 1)) {
					$emAlbumMain .= qq~
			<td align="center" width="$width1">~;
				} elsif (($per_row == 2) && ($per_cnt == 2)) {
					$emAlbumMain .= qq~
			<td align="center" width="$width2">~;
				} elsif (($per_row == 3) && ($per_cnt == 1)) {
					$emAlbumMain .= qq~
			<td align="center" width="$width1">~;
				} elsif (($per_row == 3) && ($per_cnt == 2)) {
					$emAlbumMain .= qq~
			<td align="center" width="$width2">~;
				} elsif (($per_row == 3) && ($per_cnt == 3)) {
					$emAlbumMain .= qq~
			<td align="center" width="$width3">~;
				} elsif (($per_row == 4) && ($per_cnt == 1)) {
					$emAlbumMain .= qq~
			<td align="center" width="$width1">~;
				} elsif (($per_row == 4) && ($per_cnt == 2)) {
					$emAlbumMain .= qq~
			<td align="center" width="$width2">~;
				} elsif (($per_row == 4) && ($per_cnt == 3)) {
					$emAlbumMain .= qq~
			<td align="center" width="$width3">~;
				} elsif (($per_row == 4) && ($per_cnt == 4)) {
					$emAlbumMain .= qq~
			<td align="center" width="$width4">~;
				} elsif (($per_row == 5) && ($per_cnt == 1)) {
					$emAlbumMain .= qq~
			<td align="center" width="$width1">~;
				} elsif (($per_row == 5) && ($per_cnt == 2)) {
					$emAlbumMain .= qq~
			<td align="center" width="$width2">~;
				} elsif (($per_row == 5) && ($per_cnt == 3)) {
					$emAlbumMain .= qq~
			<td align="center" width="$width3">~;
				} elsif (($per_row == 5) && ($per_cnt == 4)) {
					$emAlbumMain .= qq~
			<td align="center" width="$width4">~;
				} elsif (($per_row == 5) && ($per_cnt == 5)) {
					$emAlbumMain .= qq~
			<td align="center" width="$width5">~;
				} elsif (($per_row == 6) && ($per_cnt == 1)) {
					$emAlbumMain .= qq~
			<td align="center" width="$width1">~;
				} elsif (($per_row == 6) && ($per_cnt == 2)) {
					$emAlbumMain .= qq~
			<td align="center" width="$width2">~;
				} elsif (($per_row == 6) && ($per_cnt == 3)) {
					$emAlbumMain .= qq~
			<td align="center" width="$width3">~;
				} elsif (($per_row == 6) && ($per_cnt == 4)) {
					$emAlbumMain .= qq~
			<td align="center" width="$width4">~;
				} elsif (($per_row == 6) && ($per_cnt == 5)) {
					$emAlbumMain .= qq~
			<td align="center" width="$width5">~;
				} elsif (($per_row == 6) && ($per_cnt == 6)) {
					$emAlbumMain .= qq~
			<td align="center" width="$width6">~;
				} 

				$emAlbumMain .= qq~
			  <!-- THUMBNAIL -->
			  <table border="0" cellpadding="0" cellspacing="0" width="100%" class="displayimage">
				<tr>
				  <td rowspan="5"><img src="$image_url/trans.gif" border="0" width="5"></td>
				  <td height="15"></td>
				  <td rowspan="5"><img src="$image_url/trans.gif" border="0" width="5"></td>
				</tr>
				<tr>
				  <td class="image"><a href="$cgi_url?cmd=show_image&path=$emAlbum{'path'}&img=$image_number&tn=$emAlbum{'tn'}">$imageURL</a></td>
				</tr>~;

				if ($thumb_caption == 1) {
					$image_name = $image;
					if ($caption == 0) { $image_name = ""; }
					elsif ($caption == 2) { $image_name =~ s/\_/ /g; $image_name =~ s/\.(jpg|jpeg|jpe|bmp|gif|png|tiff|tif)$//i; }
			
					$emAlbumMain .= qq~
				<tr>
				  <td height="5"></td>
				</tr>
				<tr>
				  <td class="caption">$image_name</td>
				</tr>
				<tr>
				  <td height="10"></td>
				</tr>~;

				} else {
					$emAlbumMain .= qq~
				<tr>
				  <td height="20"></td>
				</tr>~;

				}

				$emAlbumMain .= qq~
			  </table>
			</td>~;

				if ((($per_cnt < $per_row) && ($emAlbum{'page'} != $last)) || (($per_cnt < $per_row) && ($emAlbum{'page'} == $last))) { 
					$emAlbumMain .= qq~
			<td><img src="$image_url/trans.gif" border="0" width="5"></td>~; 
				
				}

				$per_cnt++;

			}

			$show_image_count++;
			$image_number++;

		}

		$emAlbumMain .= qq~
		  </tr>~;
	
		if ($max_count < $max_rows) { 
			$emAlbumMain .= qq~
			<tr>
			  <td height="5" colspan="$column_span"></td>
			</tr>
			<tr>~; 

		}

		$show_image_count = 0;
		$show_row_count++;
		$max_count++;

	}

	$emAlbumMain .= qq~
			<tr>
			  <td height="10"></td>
			</tr>~;

	$emAlbumFooter = qq~
	<td width="5" class="footer"></td>
	<td width="*" class="footer">&nbsp;</td>
	<td width="5" class="footer"></td>~;

	# Finish up and display page
	&html;

}

sub slide_show {

	my $ss_image_path = "$album_path$slash$emAlbum{'path'}";
	# Open the image directory and get the selected image
	opendir(SLI,"$ss_image_path") || &error("111|$ss_image_path");
	my @slide_images = grep /\.(jpg|jpeg|jpe|bmp|gif|png|tiff|tif)$/i, sort readdir(SLI); #do not name images w/ a '.'
	closedir(SLI);	

	my $display_number = $emAlbum{'img'} + 1;
	unless ($emAlbum{'img'}) {
		$emAlbum{'img'} = 0;
		$display_number = 1;
	
	}

	my $next_image = $emAlbum{'img'} + 1;
	my $display_image = @slide_images[$emAlbum{'img'}];
	my $image_src = qq~<img border="2" src="$album_url/$emAlbum{'path'}/$display_image" class="imgborder" alt="$text{'1'}">~;
	my $display_name = $display_image;
	my $total_images = @slide_images;
	
	if ($caption == 0) { $display_name = ""; }
	elsif ($caption == 2) { $display_name =~ s/\_/ /g; $display_name =~ s/\.(jpg|jpeg|jpe|bmp|gif|png|tiff|tif)$//i; }

	if ($emAlbum{'path'} =~ /\//) {
		($main_folder,$folder) = split(/\//,$emAlbum{'path'});
		$folder_name = $folder;
		$folder_name =~ s/\_/ /g;
		$main_folder_name = $main_folder;
		$main_folder_name =~ s/\_/ /g;
		$emAlbumNavigation = qq~$home_link<a href="$cgi_url" class="nav">$main_link</a> $text{'8'} <a href="$cgi_url?cmd=show_sub&path=$main_folder" class="nav">$main_folder_name</a> $text{'8'} $folder_name $text{'8'}~;
		
	} elsif ($emAlbum{'path'} =~ /\\/) {
		($main_folder,$folder) = split(/\\/,$emAlbum{'path'});
		$folder_name = $folder;
		$folder_name =~ s/\_/ /g;
		$main_folder_name = $main_folder;
		$main_folder_name =~ s/\_/ /g;
		$emAlbumNavigation = qq~$home_link<a href="$cgi_url" class="nav">$main_link</a> $text{'8'} <a href="$cgi_url?cmd=show_sub&path=$main_folder" class="nav">$main_folder_name</a> $text{'8'} $folder_name $text{'8'}~;
		
	} else {
		$folder = $emAlbum{'path'};
		$folder_name = $folder;
		$folder_name =~ s/\_/ /g;
		$emAlbumNavigation = qq~$home_link<a href="$cgi_url" class="nav">$main_link</a> $text{'8'} $folder_name $text{'8'}~;

	}
	
	$emAlbumMain = qq~
			  <tr>
				<td height="10"></td>
			  </tr>
			  <tr>
				<td align="center" width="100%">
				  <!-- IMAGE -->
				  <table border="0" cellpadding="0" cellspacing="0" width="100%" class="displayimage">
					<tr>
					  <td rowspan="5"><img src="$image_url/trans.gif" border="0" width="10"></td>
					  <td height="15"></td>
					  <td rowspan="5"><img src="$image_url/trans.gif" border="0" width="10"></td>
					</tr>
					<tr>
					  <td class="image">$image_src</td>
					</tr>
					<tr>
					  <td height="5"></td>
					</tr>
					<tr>
					  <td class="caption">$display_name</td>
					</tr>
					<tr>
					  <td height="10"></td>
					</tr>
				  </table>
				</td>
			  </tr>
			  <tr>
				<td height="10"></td>
			  </tr>~;

	unless ($emAlbum{'speed'}) {
		$emAlbum{'speed'} = $default_speed;

	}

	if ($display_number >= $total_images) {
		$emAlbumSS = "";

		$slide_link = qq~$text{'32'} <a href="$cgi_url?cmd=slide_show&action=play&speed=$emAlbum{'speed'}&path=$emAlbum{'path'}&img=0&tn=$emAlbum{'tn'}">~;
		$slide_link .= qq~<img src="$image_url/restart.gif" border="0" align="absmiddle" alt="$text{'30'}"></a> ~;
		$slide_link .= qq~<img src="$image_url/pause_off.gif" border="0" align="absmiddle" alt=""> ~;
		$slide_link .= qq~<a href="$cgi_url?cmd=show_image&path=$emAlbum{'path'}&img=$emAlbum{'img'}&tn=$emAlbum{'tn'}">~;
		$slide_link .= qq~<img src="$image_url/stop.gif" border="0" align="absmiddle" alt="$text{'20'}"><a> ~;
		$slide_link .= qq~&nbsp;&nbsp; $text{'29'} <img src="$image_url/down_off.gif" border="0" align="absmiddle" alt=""> ~;
		$slide_link .= qq~<img src="$image_url/up_off.gif" border="0" align="absmiddle" alt="">~;

		$speed_info = "$text{'24'}";

	} else {
		if ($emAlbum{'action'} eq "speed_up") {
			if ($emAlbum{'speed'} > 1) {
				$emAlbum{'speed'} = $emAlbum{'speed'} - 1;

			} else {
				$emAlbum{'speed'} = 1;

			}

			$emAlbumSS = qq~<meta http-equiv="refresh" content="$emAlbum{'speed'} ;URL=$cgi_url?cmd=slide_show&action=play&speed=$emAlbum{'speed'}&path=$emAlbum{'path'}&img=$next_image&tn=$emAlbum{'tn'}">~;

			$slide_link = qq~$text{'32'} <img src="$image_url/play_off.gif" border="0" align="absmiddle" alt="$text{'26'}"> ~;
			$slide_link .= qq~<a href="$cgi_url?cmd=slide_show&action=pause&speed=$emAlbum{'speed'}&path=$emAlbum{'path'}&img=$emAlbum{'img'}&tn=$emAlbum{'tn'}">~;
			$slide_link .= qq~<img src="$image_url/pause.gif" border="0" align="absmiddle" alt="$text{'27'}"><a> ~;
			$slide_link .= qq~<a href="$cgi_url?cmd=show_image&path=$emAlbum{'path'}&img=$emAlbum{'img'}&tn=$emAlbum{'tn'}">~;
			$slide_link .= qq~<img src="$image_url/stop.gif" border="0" align="absmiddle" alt="$text{'20'}"><a> ~;
			$slide_link .= qq~&nbsp;&nbsp; $text{'29'} <a href="$cgi_url?cmd=slide_show&action=slow_down&speed=$emAlbum{'speed'}&path=$emAlbum{'path'}&img=$emAlbum{'img'}&tn=$emAlbum{'tn'}"> ~;
			$slide_link .= qq~<img src="$image_url/down.gif" border="0" align="absmiddle" alt="$text{'22'}"><a> ~;
			$slide_link .= qq~<a href="$cgi_url?cmd=slide_show&action=speed_up&speed=$emAlbum{'speed'}&path=$emAlbum{'path'}&img=$emAlbum{'img'}&tn=$emAlbum{'tn'}"> ~;
			$slide_link .= qq~<img src="$image_url/up.gif" border="0" align="absmiddle" alt="$text{'21'}"><a> ~;

			$speed_info = qq~$emAlbum{'speed'} $text{'23'}~;

		} elsif ($emAlbum{'action'} eq "slow_down") {
			$emAlbum{'speed'} = $emAlbum{'speed'} + 1;
			$emAlbumSS = qq~<meta http-equiv="refresh" content="$emAlbum{'speed'} ;URL=$cgi_url?cmd=slide_show&action=play&speed=$emAlbum{'speed'}&path=$emAlbum{'path'}&img=$next_image&tn=$emAlbum{'tn'}">~;

			$slide_link = qq~$text{'32'} <img src="$image_url/play_off.gif" border="0" align="absmiddle" alt="$text{'26'}"> ~;
			$slide_link .= qq~<a href="$cgi_url?cmd=slide_show&action=pause&speed=$emAlbum{'speed'}&path=$emAlbum{'path'}&img=$emAlbum{'img'}&tn=$emAlbum{'tn'}">~;
			$slide_link .= qq~<img src="$image_url/pause.gif" border="0" align="absmiddle" alt="$text{'27'}"><a> ~;
			$slide_link .= qq~<a href="$cgi_url?cmd=show_image&path=$emAlbum{'path'}&img=$emAlbum{'img'}&tn=$emAlbum{'tn'}">~;
			$slide_link .= qq~<img src="$image_url/stop.gif" border="0" align="absmiddle" alt="$text{'20'}"><a> ~;
			$slide_link .= qq~&nbsp;&nbsp; $text{'29'} <a href="$cgi_url?cmd=slide_show&action=slow_down&speed=$emAlbum{'speed'}&path=$emAlbum{'path'}&img=$emAlbum{'img'}&tn=$emAlbum{'tn'}"> ~;
			$slide_link .= qq~<img src="$image_url/down.gif" border="0" align="absmiddle" alt="$text{'22'}"><a> ~;
			$slide_link .= qq~<a href="$cgi_url?cmd=slide_show&action=speed_up&speed=$emAlbum{'speed'}&path=$emAlbum{'path'}&img=$emAlbum{'img'}&tn=$emAlbum{'tn'}"> ~;
			$slide_link .= qq~<img src="$image_url/up.gif" border="0" align="absmiddle" alt="$text{'21'}"><a> ~;

			$speed_info = qq~$emAlbum{'speed'} $text{'23'}~;

		} elsif ($emAlbum{'action'} eq "play") {
			$emAlbumSS = qq~<meta http-equiv="refresh" content="$emAlbum{'speed'} ;URL=$cgi_url?cmd=slide_show&action=play&speed=$emAlbum{'speed'}&path=$emAlbum{'path'}&img=$next_image&tn=$emAlbum{'tn'}">~;
			
			$slide_link = qq~$text{'32'} <img src="$image_url/play_off.gif" border="0" align="absmiddle" alt="$text{'26'}"> ~;
			$slide_link .= qq~<a href="$cgi_url?cmd=slide_show&action=pause&speed=$emAlbum{'speed'}&path=$emAlbum{'path'}&img=$emAlbum{'img'}&tn=$emAlbum{'tn'}">~;
			$slide_link .= qq~<img src="$image_url/pause.gif" border="0" align="absmiddle" alt="$text{'27'}"><a> ~;
			$slide_link .= qq~<a href="$cgi_url?cmd=show_image&path=$emAlbum{'path'}&img=$emAlbum{'img'}&tn=$emAlbum{'tn'}">~;
			$slide_link .= qq~<img src="$image_url/stop.gif" border="0" align="absmiddle" alt="$text{'20'}"><a> ~;
			$slide_link .= qq~&nbsp;&nbsp; $text{'29'} <a href="$cgi_url?cmd=slide_show&action=slow_down&speed=$emAlbum{'speed'}&path=$emAlbum{'path'}&img=$emAlbum{'img'}&tn=$emAlbum{'tn'}"> ~;
			$slide_link .= qq~<img src="$image_url/down.gif" border="0" align="absmiddle" alt="$text{'22'}"><a> ~;
			$slide_link .= qq~<a href="$cgi_url?cmd=slide_show&action=speed_up&speed=$emAlbum{'speed'}&path=$emAlbum{'path'}&img=$emAlbum{'img'}&tn=$emAlbum{'tn'}"> ~;
			$slide_link .= qq~<img src="$image_url/up.gif" border="0" align="absmiddle" alt="$text{'21'}"><a> ~;

			$speed_info = qq~$emAlbum{'speed'} $text{'23'}~;

		} elsif ($emAlbum{'action'} eq "pause") {
			$emAlbumSS = "";
			
			$slide_link = qq~$text{'32'} <a href="$cgi_url?cmd=slide_show&action=play&speed=$emAlbum{'speed'}&path=$emAlbum{'path'}&img=$emAlbum{'img'}&tn=$emAlbum{'tn'}">~;
			$slide_link .= qq~<img src="$image_url/play.gif" border="0" align="absmiddle" alt="$text{'19'}"></a> ~;
			$slide_link .= qq~<img src="$image_url/pause_off.gif" border="0" align="absmiddle" alt=""> ~;
			$slide_link .= qq~<a href="$cgi_url?cmd=show_image&path=$emAlbum{'path'}&img=$emAlbum{'img'}&tn=$emAlbum{'tn'}">~;
			$slide_link .= qq~<img src="$image_url/stop.gif" border="0" align="absmiddle" alt="$text{'20'}"><a> ~;
			$slide_link .= qq~&nbsp;&nbsp; $text{'29'} <img src="$image_url/down_off.gif" border="0" align="absmiddle" alt=""> ~;
			$slide_link .= qq~<img src="$image_url/up_off.gif" border="0" align="absmiddle" alt="$text{'21'}">~;

			$speed_info = qq~$text{'28'}~;

		}

	}


	$emAlbumHeader = qq~
		<td width="10"></td>
		<td width="20%" class="menuleft">$text{'14'} <b>$display_number</b> $text{'15'} <b>$total_images</b></td>
		<td width="*%" class="menucenter">$slide_link</td>
		<td width="20%" class="menuright">$speed_info</td>
		<td width="10"></td>~;

	$emAlbumFooter = qq~
		<td width="5" class="footer"></td>
		<td width="*" class="footer"></td>
		<td width="5" class="footer"></td>~;

	&html;

}

sub html {
	$emAlbumCP = qq~
	  <tr>
	    <td width="100%" class="cp">$text{'pb'}</td>
	  </tr>
	  <tr>
	    <td width="100%" class="cp">$text{'cp'}</td>
	  </tr>~;

	# Open template
	open(TMP,$template_path);
	my @template = <TMP>;
	close(TMP);

	if (($text{'pb'} !~ /emAlbum/) || ($text{'cp'} !~ /emAlbum/)) {
		&error("112|");
	
	}

	# Search template for triggers and put in data
	foreach $line (@template) {
		if ($line =~ "<emAlbumSS>") { $line =~ s/<emAlbumSS>/$emAlbumSS/g; }
		if ($line =~ "<emAlbumTitle>") { $line =~ s/<emAlbumTitle>/$title/g; }
		if ($line =~ "<emAlbumNavigation>") { $line =~ s/<emAlbumNavigation>/$emAlbumNavigation/g; }
		if ($line =~ "<emAlbumHeader>") { $line =~ s/<emAlbumHeader>/$emAlbumHeader/g; }
		if ($line =~ "<emAlbumMain>") { $line =~ s/<emAlbumMain>/$emAlbumMain/g; }
		if ($line =~ "<emAlbumFooter>") { $line =~ s/<emAlbumFooter>/$emAlbumFooter/g; }
		if ($line =~ "<emAlbumCP>") { $line =~ s/<emAlbumCP>/$emAlbumCP/g; $cp = 1; }
		if ($line =~ "<emAlbumImageURL>") { $line =~ s/<emAlbumImageURL>/$image_url/g; }
	}

	if ($cp != 1) { &error("113|&lt;emAlbumCP&gt;"); }

	# Display the page and exit the script
	print(@template);
	exit(0);

}

sub error {
	($err) = @_;

	($err_num,$err_msg) = split(/\|/,$err);

	if ($err == 100) {
		print qq~
<html>
<head>
<title>emAlbum Error</title>
</head>
<body>
<table border="0" cellpadding="0" cellspacing="0" width="600">
  <tr>
	<td width="100%"><b>$text{'err'}</b></td>
  </tr>
  <tr>
	<td width="100%">&nbsp;</td>
  </tr>
  <tr>
	<td width="100%"><i>$text{'err_code'}</i> $err_num</td>
  </tr>
  <tr>
	<td width="100%"><i>$text{'err_msg'}</i> $text{"$err_num"} $err_msg</td>
  </tr>
  <tr>
	<td width="100%">&nbsp;</td>
  </tr>
  <tr>
	<td width="100%">$text{'err_rpt'} <a href="mailto:$admin_email?subject=emAlbum $text{'err_code'} $err_num">$text{'err_rpt1'}</a> $text{'err_rpt2'}</td>
  </tr>
</table>
</body>
</html>~;

	} else {
		# Open template
		open(TMP,$template_path);
		my @template = <TMP>;
		close(TMP);

		$emAlbumNavigation = qq~
		<a href="$cgi_url" class="nav">$main_link</a> $text{'8'} $text{'err1'} $text{'8'}~;
		$emAlbumHeader = qq~
		<td width="5"></td>
		<td width="*" class="menuleft">$text{'err'}</td>
		<td width="5"></td>~;
		$emAlbumMain = qq~
	  <tr>
		<td width="100%">&nbsp;</td>
	  </tr>
	  <tr>
		<td width="100%" class="album"><i>$text{'err_code'}</i> $err_num</td>
	  </tr>
	  <tr>
		<td width="100%" class="album"><i>$text{'err_msg'}</i> $text{"$err_num"} $err_msg</td>
	  </tr>
	  <tr>
		<td width="100%">&nbsp;</td>
	  </tr>
	  <tr>
		<td width="100%" class="info">$text{'err_rpt'} <a href="mailto:$admin_email?subject=emAlbum $text{'err_code'} $err_num">$text{'err_rpt1'}</a> $text{'err_rpt2'}</td>
	  </tr>~;
		$emAlbumFooter = qq~
		<td class="footer">&nbsp;</td>~;
		$emAlbumCP = qq~
	  <tr>
	    <td width="100%" class="cp">$text{'pb'}</td>
	  </tr>
	  <tr>
	    <td width="100%" class="cp">$text{'cp'}</td>
	  </tr>~;
		
		foreach $line (@template) {
			if ($line =~ "<emAlbumSS>") { $line =~ s/<emAlbumSS>//g; }
			if ($line =~ "<emAlbumTitle>") { $line =~ s/<emAlbumTitle>/$title/g; }
			if ($line =~ "<emAlbumNavigation>") { $line =~ s/<emAlbumNavigation>/$emAlbumNavigation/g; }
			if ($line =~ "<emAlbumHeader>") { $line =~ s/<emAlbumHeader>/$emAlbumHeader/g; }
			if ($line =~ "<emAlbumMain>") { $line =~ s/<emAlbumMain>/$emAlbumMain/g; }
			if ($line =~ "<emAlbumFooter>") { $line =~ s/<emAlbumFooter>/$emAlbumFooter/g; }
			if ($line =~ "<emAlbumImageURL>") { $line =~ s/<emAlbumImageURL>/$image_url/g; }
		}

		print(@template);

	}

	exit(0);

}