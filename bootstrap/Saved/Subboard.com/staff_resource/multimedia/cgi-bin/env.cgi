#!C:\Perl\bin\Perl

###########################################
# env.cgi                                 #
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

# Confirm the path to Perl in the first line of this script
# Set the appropriate permissions (755) if needed
# Execute this script
# To help with your server paths, look for the value of DOCUMENT_ROOT

print "Content-type: text/html\n\n<br><br>";

while (($key, $val) = each %ENV) {
        print "$key = $val<BR>\n";
}

print '$>,$<, $), $( = ', "$>, $<, $), $( \n";

