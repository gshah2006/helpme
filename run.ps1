#Basically I want to run a script that will sort of do an "EOS" on a machine. First step is to set time by running this command below. The part that says "Eastern Standard Time", I was hoping to have that part replaced with user input, like pressing 1, would input exactly "Pacific Standard Time" as the tzutil time only works if there are no typos. After this, I want to run other commands one by one, in a particular order.
#
#tzutil /s "Eastern Standard Time";net time /domain:domainname /set /y
#Please help with #command1 & #command2. Thanks!!

#Command1
@echo off
echo 'Select Time Zone:'

function Show-Menu
{
    param (
        [string]$Title = 'List of Timezones'
    )
    Clear-Host
    Write-Host "================ $Title ================"
    
    Write-Host "1: Press '1' for Pacific Standard Time"
    Write-Host "2: Press '2' for Eastern Standard Time."
    Write-Host "3: Press '3' for Mountain Standard Time"
    Write-Host "4: Press '4' for Central Standard Time"
    Write-Host "Q: Press 'Q' to quit."
}

do
{
     Show-Menu
     $timezoneselected = Read-Host "Please make a selection"
     switch ($timezoneselected)
     {
           '1' {
                cls
                'You chose option #1'
           } '2' {
                cls
                'You chose option #2'
           } '3' {
                cls
                'You chose option #3'
           } '4' {
                cls
                'You chose option #4'     
           } 'q' {
                return
           }
     }
     pause
}
until ($timezoneselected -eq '1' or $timezoneselected -eq '2' or $timezoneselected -eq '3' or $timezoneselected -eq '4' or $timezoneselected -eq 'q')

#Command2
echo 'Checking for Citrix-Admins AD Group in Administrators group'
net localgroup Administrators | findstr -i Citrix-Admins
$groupgrep = Citrix-Admins

if($groupgrep -eq Citrix-Admins){
   write-host("AD Group: Citrix-Admins exists") do 
} else(chef-client.bat -s 0){
   write-host("Running Chef")
}

#Command3 - if there is a response to this which says .Net 3.5 is installed, how do I keep going on. 
Get-ChildItem 'HKLM:\SOFTWARE\Microsoft\NET Framework Setup\NDP' -Recurse | Get-ItemProperty -Na
me Version, Release -ErrorAction 0 | where { $_.PSChildName -match '^(?!S)\p{L}'} | select PSChildName, Version, Release
 | findstr -i v3.5
