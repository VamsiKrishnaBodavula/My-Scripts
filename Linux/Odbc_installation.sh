## this will check if odbc driver is installed in the VM, 
if ! dpkg -l | grep -q "msodbcsql18"; then
    echo "msodbcsql18 driver is not installed. Installing...";
    # Install the msodbcsql18 driver
    sudo apt-get update
    sudo ACCEPT_EULA=Y apt-get install -y msodbcsql18
    # optional: for bcp and sqlcmd
    sudo ACCEPT_EULA=Y apt-get install -y mssql-tools18
    echo 'export PATH="$PATH:/opt/mssql-tools18/bin"' >> ~/.bashrc
    source ~/.bashrc
    # optional: for unixODBC development headers
    sudo apt-get install -y unixodbc-dev
else
    echo "msodbcsql18 driver is already installed.";
fi
