@Echo off
Powershell.exe -file "C:\Users\weather\QuincyWA.ps1"
Echo.
Echo Quincy Data file is stored at C:\Users\Weather as QuincyWeatherData.CSV
Echo.
Powershell.exe -file "C:\Users\weather\PearsallTexas.ps1"
Echo.
Echo Pearsall Data file is stored at C:\Users\Weather as PearsallWeatherData.CSV
Echo.
Pause