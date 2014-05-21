# Written by James Kelly July 2012.
# Update Office Phone numbers in AD.  The commands will search for extension numbers beinging with 7,6,5 or 4.
# it will then prepend the first 9 digits of the DDI. i.e. +44141566 etc.
# A scope can be added by adding a searchbase option to the get-aduser command:
# (-SearchBase "OU=IT,OU=GLA,DC=hymans,DC=co,DC=uk")
# TREAT WITH CAUTION - THIS SCRIPT WILL BULK UPDATE AD.

# Setting up Variables
$GLANUMBER="+44141566"
$LONNUMBER="+44207082"
$EDINUMBER="+44131656"
$BIRNUMBER="+44121210"

# executing commands to update AD Users.  The '%' is an alias for 'ForEach'.
$users = Get-ADUser -Properties OfficePhone -filter * | where-object {$_.OfficePhone -ne $Null -and $_.officephone.length -eq 4} #| ft # -SearchBase "OU=IT,OU=GLA,DC=hymans,DC=co,DC=uk" | % {Set-ADUser $_ -OfficePhone($GLANUMBER+$_.OfficePhone)}

foreach ($u in $users)
{
    if($u.OfficePhone -like "7***")
    {
        set-aduser $u -officephone($GLANUMBER+$u.OfficePhone)
    }
    if($u.officephone -like "6***")
    {
        set-aduser $u -officephone($LONNUMBER+$u.officephone)
    }
    if($u.officephone -like "4***")
    {
        set-aduser $u -officephone($BIRNUMBER+$u.OfficePhone)
    }
    if($u.officephone -like "5***")
    {
        set-aduser $u -officephone($EDINUMBER+$u.officephone)
    }

}