#!C:\Perl\bin\Perl

###########################################
# emAlbum_setup.cgi 2.03                  #
#=========================================#
# emAlbum v2.1                            #
# Standard Edition                        #
#-----------------------------------------#
# First Created: 2/17/03                  #
# Last Updated: 8/13/03                   #
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

use CGI::Carp qw(fatalsToBrowser);

$lwp = 0;
$lwp_err = 0;
eval "use LWP::UserAgent";
if ($@) { $lwp = 0; } else { $lwp = 1; }
eval "use HTTP::Request";
if ($@) { $lwp = 0; } else { $lwp = 1; }

$cgi_path = $ENV{'PATH_TRANSLATED'} || $ENV{'SCRIPT_FILENAME'};
$cgi_path =~ s/emAlbum_setup.cgi//;

print "Content-type: text/html\n\n";

$pv = $^V ? join('.', unpack 'C*', $^V) : $]; 
$perl_ver = substr($pv, 0, 1);
$which = $^X;
$operating_system = $^O;
if ($^O =~ /win/i) { $slash = "\\"; $os = "win";} 
else { $slash = "/"; }

$version = "emAlbum v2.1";
$error = 0;

#Check for emAlbum.cfg
my $config_file = $cgi_path."emAlbum".$slash."settings.cfg";
unless (-e $config_file) {
	$error = 1;
	$status = qq~
  <tr valign="top">
	<td width="350" class="album">$config_file</td>
	<td width="75" class="albumred">FAILED</td>
	<td width="254" class="albumitalic">emAlbum cannot locate your configuration file (\$config_file)</td>
  </tr>~;
	&html;

} else { 
	require "$config_file";
	$status = qq~
  <tr valign="top">
	<td width="350" class="album">$config_file</td>
	<td width="75" class="albumbold">Passed</td>
	<td width="254" class="albumitalic">Configuration File Exists</td>
  </tr>~;

} 

#Check for language file
my $language_file = $cgi_path."emAlbum".$slash."language".$slash.$language;
unless (-e $language_file) {
	$error = 1;
	$status .= qq~
  <tr valign="top">
	<td width="350" class="album">$language_file</td>
	<td width="75" class="albumred">FAILED</td>
	<td width="254" class="albumitalic">emAlbum cannot locate your language file (\$language_file)</td>
  </tr>~;
	&html;

} else { 
	$status .= qq~
  <tr valign="top">
	<td width="350" class="album">$language_file</td>
	<td width="75" class="albumbold">Passed</td>
	<td width="254" class="albumitalic">Language File Exists</td>
  </tr>~;

} 

#Check for template
$template_path = $cgi_path."emAlbum".$slash."templates".$slash.$template.".html";
unless (-e $template_path) {
	$error = 1;
	$status .= qq~
  <tr valign="top">
	<td width="350" class="album">$template_path</td>
	<td width="75" class="albumred">FAILED</td>
	<td width="254" class="albumitalic">emAlbum cannot locate your template file (\$template_path)</td>
  </tr>~;
	&html;

} else { 
	$status .= qq~
  <tr valign="top">
	<td width="350" class="album">$template_path</td>
	<td width="75" class="albumbold">Passed</td>
	<td width="254" class="albumitalic">Template File Exists</td>
  </tr>~;

}

#Check to see if emAlbum.cgi exists
$emCGI_path = $cgi_path."emAlbum.cgi";
unless (-e "$emCGI_path") {
	$error = 1;
	$status .= qq~
  <tr valign="top">
	<td width="350" class="album">$emCGI_path</td>
	<td width="75" class="albumred">FAILED</td>
	<td width="254" class="albumitalic">emAlbum cannot locate the emAlbum.cgi file</td>
  </tr>~;
	&html;

} else { 
	$status .= qq~
  <tr valign="top">
	<td width="350" class="album">$emCGI_path</td>
	<td width="75" class="albumbold">Passed</td>
	<td width="254" class="albumitalic">emAlbum.cgi File Exists</td>
  </tr>~;

} 



#Check to see if emAlbum.cgi is executable
unless ((-x "$emCGI_path") || ($os eq "win")) {
	$error = 1;
	$status .= qq~
  <tr valign="top">
	<td width="350" class="album">$emCGI_path</td>
	<td width="75" class="albumred">FAILED</td>
	<td width="254" class="albumitalic">Your emAlbum.cgi file is not executable</td>
  </tr>~;
	&html;

} else { 
	$status .= qq~
  <tr valign="top">
	<td width="350" class="album">$emCGI_path</td>
	<td width="75" class="albumbold">Passed</td>
	<td width="254" class="albumitalic">emAlbum.cgi File is Executable</td>
  </tr>~;

} 

#Check to see if Template Images URL exists
if ($lwp == 1) {
	$tmpl_image_url = "$image_url/$template";
	$ua = LWP::UserAgent->new;
	$request = HTTP::Request->new(GET => "$tmpl_image_url");
	$response = $ua->request($request);  
	unless ($response->code != 404) {
		$error = 1;
		$status .= qq~
	  <tr valign="top">
		<td width="350" class="album">$tmpl_image_url</td>
		<td width="75" class="albumred">FAILED</td>
		<td width="254" class="albumitalic">emAlbum cannot locate your Template Images URL (\$tmpl_image_url)</td>
	  </tr>~;
		&html;

	} else { 
		$status .= qq~
	  <tr valign="top">
		<td width="350" class="album">$tmpl_image_url</td>
		<td width="75" class="albumbold">Passed</td>
		<td width="254" class="albumitalic">Template Image URL Exists</td>
	  </tr>~;

	} 

} else {
	$lwp_err = 1;
	$tmpl_image_url = "$image_url/$template";
	$status .= qq~
	  <tr valign="top">
		<td width="350" class="album">$tmpl_image_url</td>
		<td width="75" class="albumred">FAILED</td>
		<td width="254" class="albumitalic">emAlbum cannot test your Template Images URL (\$tmpl_image_url) *</td>
	  </tr>~;

}

#Check to see if albums url exists
if ($lwp == 1) {
	$ua = LWP::UserAgent->new;
	$request = HTTP::Request->new(GET => "$album_url");
	$response = $ua->request($request);  
	unless ($response->code != 404) {
		$error = 1;
		$status .= qq~
	  <tr valign="top">
		<td width="350" class="album">$album_url</td>
		<td width="75" class="albumred">FAILED</td>
		<td width="254" class="albumitalic">emAlbum cannot locate your Albums URL (\$album_url)</td>
	  </tr>~;
		&html;

	} else { 
		$status .= qq~
	  <tr valign="top">
		<td width="350" class="album">$album_url</td>
		<td width="75" class="albumbold">Passed</td>
		<td width="254" class="albumitalic">Album URL Exists</td>
	  </tr>~;

	} 

} else {
	$lwp_err = 1;
	$status .= qq~
	  <tr valign="top">
		<td width="350" class="album">$album_url</td>
		<td width="75" class="albumred">FAILED</td>
		<td width="254" class="albumitalic">emAlbum cannot test your Albums URL (\$album_url) *</td>
	  </tr>~;

}

#Check to see if the thumbnail url exists
if ($use_thumbs == 1) {
	if ($lwp == 1) {
		$ua = LWP::UserAgent->new;
		$request = HTTP::Request->new(GET => "$thumbs_url");
		$response = $ua->request($request);  
		unless ($response->code != 404) {
			$error = 1;
			$status .= qq~
		  <tr valign="top">
			<td width="350" class="album">$thumbs_url</td>
			<td width="75" class="albumred">FAILED</td>
			<td width="254" class="albumitalic">emAlbum cannot locate your Thumbnail URL (\$thumbs_url)</td>
		  </tr>~;
			&html;

		} else { 
			$status .= qq~
		  <tr valign="top">
			<td width="350" class="album">$thumbs_url</td>
			<td width="75" class="albumbold">Passed</td>
			<td width="254" class="albumitalic">Thubmnail URL Exists</td>
		  </tr>~;

		}

	} else {
		$lwp_err = 1;
		$status .= qq~
		  <tr valign="top">
			<td width="350" class="album">$thumbs_url</td>
			<td width="75" class="albumred">FAILED</td>
			<td width="254" class="albumitalic">emAlbum cannot test your Thumbnail URL (\$thumbs_url) *</td>
		  </tr>~;

	}

}

#Check the Home Link URL
if ($home == 1) {
	if ($lwp == 1) {
		$ua = LWP::UserAgent->new;
		$request = HTTP::Request->new(GET => "$home_url");
		$response = $ua->request($request);  
		unless ($response->code != 404) {
			$error = 1;
			$status .= qq~
	  <tr valign="top">
		<td width="350" class="album">$home_url</td>
		<td width="75" class="albumred">FAILED</td>
		<td width="254" class="albumitalic">emAlbum cannot locate your Home Page URL (\$home_url)</td>
	  </tr>~;
			&html;

		} else { 
			$status .= qq~
	  <tr valign="top">
		<td width="350" class="album">$home_url</td>
		<td width="75" class="albumbold">Passed</td>
		<td width="254" class="albumitalic">Home Page URL Exists</td>
	  </tr>~;

		}

	} else {
		$lwp_err = 1;
		$status .= qq~
	  <tr valign="top">
		<td width="350" class="album">$home_url</td>
		<td width="75" class="albumred">FAILED</td>
		<td width="254" class="albumitalic">emAlbum cannot test your Home Page URL (\$home_url) *</td>
	  </tr>~;

	}

}

#Check to see if $album_path exists
unless (-e $album_path) {
	$error = 1;
	$status .= qq~
  <tr valign="top">
	<td width="350" class="album">$album_path</td>
	<td width="75" class="albumred">FAILED</td>
	<td width="254" class="albumitalic">emAlbum cannot locate your album directory (\$album_path)</td>
  </tr>~;
	&html;

} else { 
	$status .= qq~
  <tr valign="top">
	<td width="350" class="album">$album_path</td>
	<td width="75" class="albumbold">Passed</td>
	<td width="254" class="albumitalic">Album Directory Exists</td>
  </tr>~;

} 

#Check to see if $thumbs_path exists
if ($use_thumbs == 1) {
	unless (-e $thumbs_path) {
		$error = 1;
		$status .= qq~
	  <tr valign="top">
		<td width="350" class="album">$thumbs_path</td>
		<td width="75" class="albumred">FAILED</td>
		<td width="254" class="albumitalic">emAlbum cannot locate your thumbnails directory (\$thumbs_path)</td>
	  </tr>~;
		&html;

	} else { 
		$status .= qq~
	  <tr valign="top">
		<td width="350" class="album">$thumbs_path</td>
		<td width="75" class="albumbold">Passed</td>
		<td width="254" class="albumitalic">Thubmnail Directory Exists</td>
	  </tr>~;

	} 

}

#Check to see if $use_thumbs is valid
unless (($use_thumbs == 0) || ($use_thumbs == 1)) {
	$error = 1;
	$status .= qq~
  <tr valign="top">
	<td width="350" class="album">\$use_thumbs = $use_thumbs</td>
	<td width="75" class="albumred">FAILED</td>
	<td width="254" class="albumitalic">emAlbum has detected an invalid variable (\$use_thumbs)</td>
  </tr>~;
	&html;

} else { 
	$status .= qq~
  <tr valign="top">
	<td width="350" class="album">\$use_thumbs = $use_thumbs</td>
	<td width="75" class="albumbold">Passed</td>
	<td width="254" class="albumitalic">\$use_thumbs is Valid</td>
  </tr>~;

}

#Check to see if $thumbs_place is valid
unless (($thumbs_place == 0) || ($thumbs_place == 1)) {
	$error = 1;
	$status .= qq~
  <tr valign="top">
	<td width="350" class="album">\$thumbs_place = $thumbs_place</td>
	<td width="75" class="albumred">FAILED</td>
	<td width="254" class="albumitalic">emAlbum has detected an invalid variable (\$thumbs_place)</td>
  </tr>~;
	&html;

} else { 
	$status .= qq~
  <tr valign="top">
	<td width="350" class="album">\$thumbs_place = $thumbs_place</td>
	<td width="75" class="albumbold">Passed</td>
	<td width="254" class="albumitalic">\$thumbs_place is Valid</td>
  </tr>~;

}

#Check to see if $per_row is valid
unless (($per_row >= 1) && ($per_row <= 6)) {
	$error = 1;
	$status .= qq~
  <tr valign="top">
	<td width="350" class="album">\$per_row = $per_row</td>
	<td width="75" class="albumred">FAILED</td>
	<td width="254" class="albumitalic">emAlbum has detected an invalid variable (\$per_row)</td>
  </tr>~;
	&html;

} else { 
	$status .= qq~
  <tr valign="top">
	<td width="350" class="album">\$per_row = $per_row</td>
	<td width="75" class="albumbold">Passed</td>
	<td width="254" class="albumitalic">\$per_row is Valid</td>
  </tr>~;

} 

#Check to see if $max_rows is valid
unless ($max_rows >= 1) {
	$error = 1;
	$status .= qq~
  <tr valign="top">
	<td width="350" class="album">\$max_rows = $max_rows</td>
	<td width="75" class="albumred">FAILED</td>
	<td width="254" class="albumitalic">emAlbum has detected an invalid variable (\$max_rows)</td>
  </tr>~;
	&html;

} else { 
	$status .= qq~
  <tr valign="top">
	<td width="350" class="album">\$max_rows = $max_rows</td>
	<td width="75" class="albumbold">Passed</td>
	<td width="254" class="albumitalic">\$max_rows is Valid</td>
  </tr>~;

} 

#Check to see if $drop is valid
unless (($drop == 0) || ($drop == 1)) {
	$error = 1;
	$status .= qq~
  <tr valign="top">
	<td width="350" class="album">\$drop = $drop</td>
	<td width="75" class="albumred">FAILED</td>
	<td width="254" class="albumitalic">emAlbum has detected an invalid variable (\$drop)</td>
  </tr>~;
	&html;

} else { 
	$status .= qq~
  <tr valign="top">
	<td width="350" class="album">\$drop = $drop</td>
	<td width="75" class="albumbold">Passed</td>
	<td width="254" class="albumitalic">\$drop is Valid</td>
  </tr>~;

}

#Check to see if $caption is valid
unless (($caption >= 0) && ($caption <= 2)) {
	$error = 1;
	$status .= qq~
  <tr valign="top">
	<td width="350" class="album">\$caption = $caption</td>
	<td width="75" class="albumred">FAILED</td>
	<td width="254" class="albumitalic">emAlbum has detected an invalid variable (\$caption)</td>
  </tr>~;
	&html;

} else { 
	$status .= qq~
  <tr valign="top">
	<td width="350" class="album">\$caption = $caption</td>
	<td width="75" class="albumbold">Passed</td>
	<td width="254" class="albumitalic">\$caption is Valid</td>
  </tr>~;

} 

#Check to see if $thumb_caption is valid
unless (($thumb_caption == 0) || ($thumb_caption == 1)) {
	$error = 1;
	$status .= qq~
  <tr valign="top">
	<td width="350" class="album">\$thumb_caption = $thumb_caption</td>
	<td width="75" class="albumred">FAILED</td>
	<td width="254" class="albumitalic">emAlbum has detected an invalid variable (\$thumb_caption)</td>
  </tr>~;
	&html;

} else { 
	$status .= qq~
  <tr valign="top">
	<td width="350" class="album">\$thumb_caption = $thumb_caption</td>
	<td width="75" class="albumbold">Passed</td>
	<td width="254" class="albumitalic">\$thumb_caption is Valid</td>
  </tr>~;

} 

#Check to see if $use_update is valid
unless (($use_update == 0) || ($use_update == 1)) {
	$error = 1;
	$status .= qq~
  <tr valign="top">
	<td width="350" class="album">\$use_update = $use_update</td>
	<td width="75" class="albumred">FAILED</td>
	<td width="254" class="albumitalic">emAlbum has detected an invalid variable (\$use_update)</td>
  </tr>~;
	&html;

} else { 
	$status .= qq~
  <tr valign="top">
	<td width="350" class="album">\$use_update = $use_update</td>
	<td width="75" class="albumbold">Passed</td>
	<td width="254" class="albumitalic">\$use_update is Valid</td>
  </tr>~;

} 

#Check to see if $update_range is valid
unless (($update_range >= 1) && ($update_range <= 30)) {
	$error = 1;
	$status .= qq~
  <tr valign="top">
	<td width="350" class="album">\$update_range = $update_range</td>
	<td width="75" class="albumred">FAILED</td>
	<td width="254" class="albumitalic">emAlbum has detected an invalid variable (\$update_range)</td>
  </tr>~;
	&html;

} else { 
	$status .= qq~
  <tr valign="top">
	<td width="350" class="album">\$update_range = $update_range</td>
	<td width="75" class="albumbold">Passed</td>
	<td width="254" class="albumitalic">\$update_range is Valid</td>
  </tr>~;

}

#Check to see if $slide_show is valid
unless (($slide_show == 0) || ($slide_show == 1)) {
	$error = 1;
	$status .= qq~
  <tr valign="top">
	<td width="350" class="album">\$slide_show = $slide_show</td>
	<td width="75" class="albumred">FAILED</td>
	<td width="254" class="albumitalic">emAlbum has detected an invalid variable (\$slide_show)</td>
  </tr>~;
	&html;

} else { 
	$status .= qq~
  <tr valign="top">
	<td width="350" class="album">\$slide_show = $slide_show</td>
	<td width="75" class="albumbold">Passed</td>
	<td width="254" class="albumitalic">\$slide_show is Valid</td>
  </tr>~;

} 

#Check to see if $default_speed is valid
unless ($default_speed >= 1) {
	$error = 1;
	$status .= qq~
  <tr valign="top">
	<td width="350" class="album">\$default_speed = $default_speed</td>
	<td width="75" class="albumred">FAILED</td>
	<td width="254" class="albumitalic">emAlbum has detected an invalid variable (\$default_speed)</td>
  </tr>~;
	&html;

} else { 
	$status .= qq~
  <tr valign="top">
	<td width="350" class="album">\$default_speed = $default_speed</td>
	<td width="75" class="albumbold">Passed</td>
	<td width="254" class="albumitalic">\$default_speed is Valid</td>
  </tr>~;

} 

#Check to see if $cgi_index is valid
unless (($cgi_index == 0) || ($cgi_index == 1)) {
	$error = 1;
	$status .= qq~
  <tr valign="top">
	<td width="350" class="album">\$cgi_index = $cgi_index</td>
	<td width="75" class="albumred">FAILED</td>
	<td width="254" class="albumitalic">emAlbum has detected an invalid variable (\$cgi_index)</td>
  </tr>~;
	&html;

} else { 
	$status .= qq~
  <tr valign="top">
	<td width="350" class="album">\$cgi_index = $cgi_index</td>
	<td width="75" class="albumbold">Passed</td>
	<td width="254" class="albumitalic">\$cgi_index is Valid</td>
  </tr>~;

} 

&html;

sub html {
	$this_script = $ENV{'SCRIPT_NAME'};
	$main_script = $this_script; $main_script =~ s/emAlbum_setup.cgi/emAlbum.cgi/;
	$emAlbumMain = qq~
  <tr>
	<td width="100%" colspan="3" height="15"></td>
  </tr>
  $status
  <tr>
	<td width="100%" colspan="3" class="info"></td>
  </tr>~;

	if ($lwp_err == 1) {
		$emAlbumMain .= qq~
  <tr>
	<td width="100%" colspan="3" height="15"></td>
  </tr>
  <tr>
	<td width="100%" colspan="3" class="album">* emAlbum cannot test your URL's because this host does not support the following Perl Modules: <a href="http://search.cpan.org/" target="_blank">LWP::UserAgent</a> and/or <a href="http://search.cpan.org/" target="_blank">HTTP::Request</a>. If your URL variables are set correctly, emAlbum will still work.</td>
  </tr>~;

	}

	if ($error == 1) {
		$emAlbumMain .= qq~
  <tr>
	<td width="100%" colspan="3" height="15"></td>
  </tr>
  <tr>
	<td width="100%" colspan="3" class="album" align="center">Please correct the problem and then <a href="$this_script">re-run</a> this script.</td>
  </tr>
  <tr>
	<td width="100%" colspan="3" height="10"></td>
  </tr>
  <tr>
	<td width="100%" colspan="3" class="album" align="center">If you need assistance, visit our <a href="http://www.emalbum.com/support" target="_blank">support forum</a> or submit a <a href="http://www.emalbum.com/support.php?info=$ENV{'SCRIPT_FILENAME'}|$template|$language|$cgi_url|$album_path|$album_url|$image_url|$use_thumbs|$thumbs_url|$thumbs_path|$per_row|$prefix|$thumb_extension|$home|$home_url|$caption|$thumb_caption|$use_update|$update_range|$slide_show|$default_speed|$cgi_index|$admin_email|$ENV{'DOCUMENT_ROOT'}|Standard|$pv" target="_blank"><b>support email</b></a>.</td>
  </tr>~;

		$hotscripts = "";

	} else {
		$emAlbumMain .= qq~
  <tr>
	<td width="100%" colspan="3" height="15"></td>
  </tr>
  <tr>
	<td width="100%" colspan="3" class="album" align="center">Thank you for using emAlbum. Please help support our script by voting below.</td>
  </tr>	
  <tr>
	<td width="100%" colspan="3" height="5"></td>
  </tr>~;
	
		$hotscripts = qq~
		<!------ Start of HTML Code ------->
		<table width="100%" border="0" cellpadding="0" cellspacing="0" class="maintable" align="center">
		<form action="http://www.hotscripts.com/cgi-bin/rate.cgi" method="POST">
		<input type="hidden" name="ID" value="24404">
		<input type="hidden" name="external" value="1">
		  <td align="center">
			<table width="300" border="1" cellpadding="4" cellspacing="0" bordercolor="#979CB2" bgcolor="#EAEAEC">
			  <tr>
				<td class="vote" align="center">Please rate emAlbum at HotScripts.com</td>
			  </tr>
			  <tr align="center">
				<td><select name="rate" size="1">
				<option value="5" selected>Excellent! - (5/5)</option>
				<option value="4">Very Good - (4/5)</option>
				<option value="3">Good - (3/5)</option>
				<option value="2">Fair - (2/5)</option>
				<option value="1">Poor - (1/5)</option>
				</select>&nbsp;
				<input name="submit" type="submit" value="Cast My Vote!"></td>
			  </tr>
			</table>
		  </td>
		</tr>
		<tr>
		  <td height="15">&nbsp;</td>
		</tr>
		<tr>
		  <td width="100%" colspan="3" class="album" align="center">> <a href="$main_script" target="_blank">View your album</a> <</td>
        </tr>
		<tr>
		  <td height="15">&nbsp;</td>
		</tr>
		<tr>
		  <td width="100%" colspan="3" class="album" align="center">Your Version / Current Version: <b>$version</b> /<a href="http://www.emalbum.com" target="_blank"><img src="http://www.emalbum.com/version/cv.gif?$album_url" border="0" alt="Get the latest version of emAlbum"></a></td>
        </tr>
		<tr>
		  <td height="15">&nbsp;</td>
		</tr>
		</form>
		</table>
		<!------ End of HTML Code ------->~;

	}

	$title = "emAlbum Setup";
	$emAlbumNavigation = qq~Setup >~;
	$emAlbumHeader = qq~
	<td width="5"></td>
	<td width="*" class="menuleft">emAlbum Setup Results:</td>
	<td width="5"></td>~;
	$emAlbumFooter = qq~
	<td class="footer">&nbsp;</td>~;
	$emAlbumCP = qq~
  <tr>
    <td width="100%" class="cp">Powered by <a class="cp" href="http://www.emalbum.com" target="_blank">emAlbum</a></td>
  </tr>
  <tr>
    <td width="100%" class="cp">© 2003, emAlbum. All Rights Reserved.</td>
  </tr>~;

	print qq~
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title>$title</title>
<meta name="keywords" content="">
<meta name="description" content="">
<style type="text/css">
body { font-size: 10px; font-family: verdana, arial, helvetica, serif; text-align: center;
  background-color: #D0D1DB}

.navigation { font-size: 11px; font-weight: bold; color: #5D5D78; 
  font-family: verdana, arial, helvetica, serif }

.navtable {
  background-color: #F7F7F7;
  border-top-width: 10; border-top-style: none; border-top-color: transparent;
  border-bottom-width: 1; border-bottom-style: solid; border-bottom-color: #979CB2;
  border-right-width: 1; border-right-style: solid; border-right-color: #979CB2;
  border-left-width: 1; border-left-style: solid; border-left-color: #979CB2
  }

.footer { font-size: 9px; color: #979CB2; font-family: verdana, arial, helvetica, serif }

.album { font-size: 11px; color: #404040; font-family: verdana, arial, helvetica, serif }
.albumbold { font-weight: bold; font-size: 11px; color: #404040; font-family: verdana, arial, helvetica, serif }
.albumitalic { font-style: italic; font-size: 11px; color: #404040; font-family: verdana, arial, helvetica, serif }
.albumred { font-weight: bold; font-size: 11px; color: #D70500; font-family: verdana, arial, helvetica, serif }
.menuleft { text-align: left; font-size: 9px; color: #404040; font-family: verdana, arial, helvetica, serif }
.menucenter { text-align: center; font-size: 9px; color: #404040; font-family: verdana, arial, helvetica, serif }
.menuright { text-align: right; font-size: 9px; color: #404040; font-family: verdana, arial, helvetica, serif }
.info { font-size: 9px; color: #8A8A8A; font-family: verdana, arial, helvetica, serif }

.maintable  {
  background-color: #F7F7F7;
  border-top-width: 0; border-top-style: none; border-top-color: transparent;
  border-bottom-width: 0; border-bottom-style: none; border-bottom-color: transparent;
  border-right-width: 1; border-right-style: solid; border-right-color: #979CB2;
  border-left-width: 1; border-left-style: solid; border-left-color: #979CB2;
}

.topinfo  {
  background-color: #EAEAEC;
  border-top-width: 0; border-top-style: none; border-top-color: transparent; 
  border-bottom-width: 1; border-bottom-style: solid; border-bottom-color: #979CB2;
  border-right-width: 1; border-right-style: solid; border-right-color: #979CB2;
  border-left-width: 1; border-left-style: solid; border-left-color: #979CB2;
}

.bottominfo  {
  background-color: #EAEAEC; 
  border-top-width: 1; border-top-style: solid; border-top-color: #979CB2; 
  border-bottom-width: 1; border-bottom-style: solid; border-bottom-color: #979CB2; 
  border-right-width: 1; border-right-style: solid; border-right-color: #979CB2; 
  border-left-width: 1; border-left-style: solid; border-left-color: #979CB2;
}

.displayimage { 
  background-color: #FFFFFF; 
  border-top-width: 1; border-top-style: dashed; border-top-color: #979CB2; 
  border-bottom-width: 1; border-bottom-style: dashed; border-bottom-color: #979CB2; 
  border-right-width: 1; border-right-style: dashed; border-right-color: #979CB2; 
  border-left-width: 1; border-left-style: dashed; border-left-color: #979CB2;
}

.icon { text-align: left }
.imgborder { border-color: #B4B6C7 }
.image { text-align: center }
.vote { font-weight: bold; font-family: verdana, arial, helvetica, serif; font-size: 11px; color: #404040 }
.caption { text-align: center; font-family: verdana, arial, helvetica, serif; font-size: 9px; color: #003366 }
.cp { font-size: 9px; color: #404040; text-align: center; font-family: verdana, arial, helvetica, serif }

a:link { color: #404040; text-decoration: none }
a:visited { color: #404040; text-decoration: none }
a:hover { color: #648BCB; text-decoration: underline }
a:active { color: #A8ABB8; text-decoration: none }

.menu {
  font-weight: bold; text-align: left; font-family: verdana, arial, helvetica, serif; font-size: 18px; color: #5D5D78
}

.menuborder  {
  background-color: #EAEAEC;
  border-top-width: 1; border-top-style: solid; border-top-color: #979CB2; 
  border-bottom-width: 1; border-bottom-style: solid; border-bottom-color: #979CB2;
  border-right-width: 1; border-right-style: solid; border-right-color: #979CB2;
  border-left-width: 1; border-left-style: solid; border-left-color: #979CB2;
}

</style>
</head>
<body>
<table border="0" cellspacing="0" cellpadding="0" width="700">
  <tr>
    <td>
		<table border="0" cellspacing="0" cellpadding="0" class="menuborder" width="100%">
			<tr height="35">
				<td width="15" class="menu">&nbsp;</td>
				<td width="*" class="menu">$title</td>
				<td width="15" class="menu">&nbsp;</td>
			</tr>
		</table>
		<table cellpadding="0" cellspacing="0" width="100%" class="navtable">
			<tr height="25">
				<td width="8"></td>
				<td width="*" class="navigation">$emAlbumNavigation</td>
				<td width="8"></td>	    
			</tr>
		</table>
		<table cellpadding="0" cellspacing="0" width="100%" class="topinfo">
			<tr height="20">	
			  $emAlbumHeader
			</tr>
		</table>
		<table border="0" cellpadding="0" cellspacing="0" width="100%" height="300" class="maintable">
			<tr valign="top">
			<td width="10"></td>
			<td width="100%">
				<table border="0" cellpadding="0" cellspacing="0" width="97%" align="center">
					$emAlbumMain
				</table>
			</td>
			<td width="10"></td>
		  </tr>
		</table>
		<!-- END MAIN --> 
		$hotscripts
		<table cellpadding="0" cellspacing="0" width="100%" class="bottominfo">
			<tr height="23">
				<td class="footer" align="center"><a href="http://www.emalbum.com" target="_blank">emAlbum.com</a> :: <a href="http://www.emalbum.com/support" target="_blank">Support Forum</a> :: <a href="http://www.emalbum.com/contact.php" target="_blank">Contact</a> :: <a href="http://www.emalbum.com/bugreport.php?ver=Standard" target="_blank">Report a Bug</a></td>
			</tr>
		</table>
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr height="15" width="100%">
			<td></td>
			</tr>
			<tr>
				<td width="100%" class="cp">Powered by <a class="cp" href="http://www.emalbum.com" target="_blank">emAlbum</a></td>
			</tr>
			<tr>
				<td width="100%" class="cp">© 2003, emAlbum. All Rights Reserved.</td>
		 </tr>
		</table>
		</td>
	</tr>
</table>
</body>
</html>~;

exit(0);

}