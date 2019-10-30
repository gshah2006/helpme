#Basically I want to run a script that will sort of do an "EOS" on a machine. First step is to set time by running this command below. The part that says "Eastern Standard Time", I was hoping to have that part replaced with user input, like pressing 1, would input exactly "Pacific Standard Time" as the tzutil time only works if there are no typos. After this, I want to run other commands one by one, in a particular order.
#
#tzutil /s "Eastern Standard Time";net time /domain:domainname /set /y
#Please help with #command1 & #command2, and verify #command3. Thanks!!

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
                'You chose option #1';
                Break
           } '2' {
                cls
                'You chose option #2';
                Break
           } '3' {
                cls
                'You chose option #3';
                Break
           } '4' {
                cls
                'You chose option #4';
                Break
           } 'q' {
                return
           } Default {
                $timezoneselected = 'notset'
            }
     }
     pause
}
until ($timezoneselected -not 'notset')

#Command2
echo 'Checking for Citrix-Admins AD Group in Administrators group'
net localgroup Administrators | findstr -i Citrix-Admins
$groupgrep = Citrix-Admins

if($groupgrep -eq Citrix-Admins){
   write-host("AD Group: Citrix-Admins exists") do 
} else(chef-client.bat -s 0){
   write-host("Running Chef")
}

#Command3 - if there is a response to this which says .Net 3.5 is installed, how do I keep going on. Also, check if my part works because I modified another script. I would like to verify against part of "Version" instead of "PSChildName" but not sure how to get wild card working after "3.5.xxxxx"

############ Just the command I've been using...
Get-ChildItem 'HKLM:\SOFTWARE\Microsoft\NET Framework Setup\NDP' -Recurse | Get-ItemProperty -Na
me Version, Release -ErrorAction 0 | where { $_.PSChildName -match '^(?!S)\p{L}'} | select PSChildName, Version, Release
 | findstr -i v3.5
#############################

function CheckNetVersion {
$netversions =@(
  3.5
)
$installed = Get-ChildItem 'HKLM:\SOFTWARE\Microsoft\NET Framework Setup\NDP' -Recurse | Get-ItemProperty -Name Version, Release -ErrorAction 0 | where { $_.PSChildName -match '^(?!S)\p{L}'} | select PSChildName, Version, Release
$installed =(Get-ChildItem 'HKLM:\SOFTWARE\Microsoft\NET Framework Setup\NDP' -Recurse | Get-ItemProperty -Name Version, Release -ErrorAction 0 | where { $_.PSChildName -match '^(?!S)\p{L}'} | select PSChildName, Version, Release).PSChildName
$ami = $netversions | %{ if($installed -contains "v$_"){ return $True }}
if($ami){
    Write-Host '.Net 3.5 is installed.'
  } else {
    Write-Host 'This host is missing .Net v3.5!'
  }
}
CheckNetVersion
