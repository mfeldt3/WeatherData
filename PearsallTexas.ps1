#Michael Feldt 9/19
set-ExecutionPolicy unrestricted
Write-Output "Script Starting... Do not close screen`r`n"


$TodaysDate = Get-Date -Format yyyy-MM-dd
$Temp = (Get-Date).AddDays(3)
$ThreeDaysFromToday = Get-Date $Temp -Format yyyy-MM-dd

Write-Output "Gathering data for Pearsall Texas..."

Write-OutPut "Hourly Tempearture"
$URI_HourlyT = "https://graphical.weather.gov/xml/sample_products/browser_interface/ndfdXMLclient.php?whichClient=NDFDgen&zipCodeList=78061&begin=" + $TodaysDate + "&end=" + $ThreeDaysFromToday + "&Unit=e&temp=temp&Submit=Submit"
$Response_HourlyT = Invoke-RestMethod -Uri $URI_HourlyT -Method Get
$HourlyT_Values = $Response_HourlyT.dwml.data.parameters.temperature.value
$HourlyT_Times = $Response_HourlyT.dwml.data.'time-layout'.'start-valid-time'

Write-OutPut "DewPoint Temperature"
$URI_DewPointT = "https://graphical.weather.gov/xml/sample_products/browser_interface/ndfdXMLclient.php?whichClient=NDFDgen&zipCodeList=78061&begin=" + $TodaysDate + "&end=" + $ThreeDaysFromToday + "&Unit=e&dew=dew&Submit=Submit"
$Response_DewPointT = Invoke-RestMethod -Uri $URI_DewPointT -Method Get
$DewPointT_Values = $Response_DewPointT.dwml.data.parameters.temperature.value
$DewPointT_Times = $Response_DewPointT.dwml.data.'time-layout'.'start-valid-time'

Write-OutPut "Relative Humidity"
$URI_RelH = "https://graphical.weather.gov/xml/sample_products/browser_interface/ndfdXMLclient.php?whichClient=NDFDgen&zipCodeList=78061&begin=" + $TodaysDate + "&end=" + $ThreeDaysFromToday + "&Unit=e&rh=rh&Submit=Submit"
$Response_RelH = Invoke-RestMethod -Uri $URI_RelH -Method Get
$RelH_Values = $Response_RelH.dwml.data.parameters.humidity.value
$RelH_Times = $Response_RelH.dwml.data.'time-layout'.'start-valid-time'


Write-Output "Saving data to file...`r`n"

$Text = "Hourly Temperature Times, Hourly Temperature, Dewpoint Temperature, Relative Humidity`r`n"
foreach ($index in 0..$HourlyT_Values.GetUpperBound(0))
    {
        If ($index -le $HourlyT_Values.GetUpperBound(0))
        {
            $FullTime= $HourlyT_Times[$index]
            $YearCharacterNumber = 5
            $DateOnly= $FullTime.Substring(5,$FullTime.IndexOf('T')-$YearCharacterNumber)
            $TrimmedTime= $FullTime.SubString($FullTime.IndexOf('T')+1, 2)
            $FormattedTimeDate = $DateOnly + " : " + $TrimmedTime
            $Text=$Text + $TrimmedTime + ","
            $Text=$Text + $HourlyT_Values[$index] + ","
        }
        else
        {
            $Text=$Text + ","
            $Text=$Text + ","
        }
        If ($index -le $DewPointT_Values.GetUpperBound(0))
        {
            $Text=$Text + $DewPointT_Values[$index] + ","
        }
        else
        {
            $Text=$Text + ","
        }
        If ($index -le $RelH_Values.GetUpperBound(0))
        {
            $Text=$Text + $RelH_Values[$index] + "`r`n"
        }
        else
        {
            $Text=$Text + "`r`n"
        }
               
       }
   
    Write-host "Data saved to C:\Users\weather\PearsallWeatherData.csv"
   
    $Text > C:\Users\weather\PearsallWeatherData.csv