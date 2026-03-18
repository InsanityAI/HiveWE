# Clone vcpkg:
cd /opt
git clone https://github.com/microsoft/vcpkg.git

# Run the following command to build vcpkg itself:
/opt/vcpkg/bootstrap-vcpkg.sh --disableMetrics

# In /usr/local/bin directory, we can create a symbolic link to the vcpkg command:
ln -s /opt/vcpkg/vcpkg /usr/local/bin/vcpkg