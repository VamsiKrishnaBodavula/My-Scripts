## this script will check if there is an existing odbc driver in the PC, if not will install the mentioned version of driver in the windows 
# Set the temporary file path
$tempFile = "$env:USERPROFILE\Downloads\msodbcsql.msi"

# Check if the Microsoft ODBC Driver 18 for SQL Server is installed
$driverInstalled = Get-ItemProperty -Path "HKLM:\SOFTWARE\ODBC\ODBCINST.INI\ODBC Drivers" -Name "ODBC Driver 18 for SQL Server" -ErrorAction SilentlyContinue

if (-not $driverInstalled) {
    Write-Host "Microsoft ODBC Driver 18 for SQL Server is not installed. Installing..."

    # Download URL for the Microsoft ODBC Driver 18 for SQL Server from Microsoft Download Center
    $downloadUrl = "https://go.microsoft.com/fwlink/?linkid=2249006"

    # Download the installer to the Downloads folder
    Invoke-WebRequest -Uri $downloadUrl -OutFile $tempFile

    # Install the driver
    Start-Process -FilePath "msiexec" -ArgumentList "/i `"$tempFile`" /quiet /norestart IACCEPTMSODBCSQLLICENSETERMS=YES" -Wait

    # Check if the installation was successful
    $driverInstalled = Get-ItemProperty -Path "HKLM:\SOFTWARE\ODBC\ODBCINST.INI\ODBC Drivers" -Name "ODBC Driver 18 for SQL Server" -ErrorAction SilentlyContinue
    if ($driverInstalled) {
        Write-Host "Microsoft ODBC Driver 18 for SQL Server installed successfully."
    } else {
        Write-Host "Failed to install Microsoft ODBC Driver 18 for SQL Server."
    }
} else {
    Write-Host "Microsoft ODBC Driver 18 for SQL Server is already installed."
}
