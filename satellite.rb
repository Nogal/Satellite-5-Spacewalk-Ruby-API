require 'xmlrpc/client'
begin
  require 'io/console'
rescue LoadError
end
module Satellite
    class Activationkey
    #Description:
    #    Contains methods to access common activation key functions available from the web interface.
        
        def self.addChildChannels(activation_key, child_channels)
        #Description:
        #    Add child channels to an activation key.
        #Parameters:
        #    string activationKey
        #    array:
        #        string - childChannelLabel(s)
            
            begin 
                $a_client.call('activationkey.addChildChannels', $a_key, activation_key, child_channels)
            rescue XMLRPC::FaultException => e
                error_string = e.faultString.scan(/redstone.xmlrpc.XmlRpcFault: (.+$)/)
                puts error_string
                exit 2
            end
        end

        def self.addConfigChannels(activation_key, config_channels, addToTop)
        #Description:
        #    Given a list of activation keys and configuration channels, this method adds 
        #    given configuration channels to either the top or the bottom (whichever 
        #    you specify) of an activation key's configuration channels list. The ordering 
        #    of the configuration channels provided in the add list is maintained while adding. 
        #    If one of the configuration channels in the 'add' list already exists in 
        #    an activation key, the configuration channel will be re-ranked to the appropriate place.
        #Parameters:
        #    array:
        #        string - activationKey
        #    array:
        #        string - List of configuration channel labels in the ranked order.
        #    boolean addToTop
        #        true - To prepend the given channels to the beginning of the activation key's config channel list
        #        false - To append the given channels to the end of the activation key's config channel list

            begin
                $a_client.call('activationkey.addConfigChannels', $a_key, activation_key, config_channels, addToTop)
            rescue XMLRPC::FaultException => e
                error_string = e.faultString.scan(/redstone.xmlrpc.XmlRpcFault: (.+$)/)
                puts error_string
                exit 2
            end
        end

        def self.addEntitlements(activation_key, entitlements)
        #Description:
        #    Add entitlements to an activation key. 
        #    Currently only add-on entitlements are permitted: 
        #    (monitoring_entitled, provisioning_entitled, virtualization_host, virtualization_host_platform)
        #Parameters:
        #    string key
        #    array:
        #        string - entitlement label
        #            monitoring_entitled
        #            provisioning_entitled
        #            virtualization_host
        #            virtualization_host_platform

            begin
                $a_client.call('activationkey.addEntitlements', $a_key, activation_key, entitlements)
            rescue XMLRPC::FaultException => e
                error_string = e.faultString.scan(/redstone.xmlrpc.XmlRpcFault: (.+$)/)
                puts error_string
                exit 2
            end
        end

        def self.addPackageNames(activation_key, packages)
        #Description:
        #     Add packages to an activation key using package name only.
        #
        #Deprecated - being replaced by addPackages(string sessionKey, string key, array[packages])
        #
        #Parameters:
        #    string key
        #    array:
        #        string - packageName

            begin
                $a_client.call('activationkey.addPackageNames', $a_key, activation_key, packages)
            rescue XMLRPC::FaultException => e
                error_string = e.faultString.scan(/redstone.xmlrpc.XmlRpcFault: (.+$)/)
                puts error_string
                exit 2
            end
        end

        def self.addPackages(activation_key, packages)
        #Description:
        #    Add packages to an activation key.
        #Parameters:
        #    string key
        #    array:
        #        struct - packages
        #            string "name" - Package name
        #            string "arch" - Arch label - Optional

            begin
                $a_client.call('activationkey.addPackages', $a_key, activation_key, packages)
            rescue XMLRPC::FaultException => e
                error_string = e.faultString.scan(/redstone.xmlrpc.XmlRpcFault: (.+$)/)
                puts error_string
                exit 2
            end
        end
  
        def self.addServerGroups(activation_key, group_ids)
        #Description:
        #    Add server groups to an activation key.
        #Parameters:
        #    string key
        #    array:
        #        int - serverGroupId

            begin
                $a_client.call('activationkey.addServerGroups', $a_key, activation_key, group_ids)
            rescue XMLRPC::FaultException => e
                error_string = e.faultString.scan(/redstone.xmlrpc.XmlRpcFault: (.+$)/)
                puts error_string
                exit 2
            end
        end

        def self.checkConfigDeployment(activation_key)
        #Description:
        #    Check configuration file deployment status for the activation key specified.
        #Parameters:
        #    string key
        #Returns:
        #    1 if enabled, 0 if disabled, exception thrown otherwise.

            begin
                result = $a_client.call('activationkey.checkConfigDeployment', $a_key, activation_key)
            rescue XMLRPC::FaultException => e
                error_string = e.faultString.scan(/redstone.xmlrpc.XmlRpcFault: (.+$)/)
                puts error_string
                exit 2
            end

            return result
        end

        def self.create(activation_key, description, baseChannel, entitlements, universalDefault)
        #Description:
        #Create a new activation key with unlimited usage. The activation key 
        #    parameter passed in will be prefixed with the organization ID, and 
        #    this value will be returned from the create call. Eg. If the caller 
        #    passes in the key "foo" and belong to an organization with the ID 100, the actual activation key will be "100-foo".
        #Parameters:
        #    string key - Leave empty to have new key autogenerated.
        #    string description
        #    string baseChannelLabel - Leave empty to accept default.
        #    array:
        #        string - Add-on entitlement label to associate with the key.
        #            monitoring_entitled
        #            provisioning_entitled
        #            virtualization_host
        #            virtualization_host_platform
        #    boolean universalDefault
        #Returns:
        #    string - The new activation key.

            begin
                new_key = $a_client.call('activationkey.create', $a_key, activation_key, description, baseChannel, entitlements, universalDefault)
            rescue XMLRPC::FaultException => e
                error_string = e.faultString.scan(/redstone.xmlrpc.XmlRpcFault: (.+$)/)
                puts error_string
                exit 2
            end

            return new_key
        end

        def self.delete(activation_key)
        #Description:
        #    Delete an activation key.
        #Parameters:
        #    string key

            begin
                $a_client.call('activationkey.delete', $a_key, activation_key)
            rescue XMLRPC::FaultException => e
                error_string = e.faultString.scan(/redstone.xmlrpc.XmlRpcFault: (.+$)/)
                puts error_string
                exit 2
            end

        end

        def self.disableConfigDeployment(activation_key)
        #Description:
        #    Disable configuration file deployment for the specified activation key.
        #Parameters:
        #    string key

            begin
                $a_client.call('activationkey.disableConfigDeployment', $a_key, activation_key)
            rescue XMLRPC::FaultException => e
                error_string = e.faultString.scan(/redstone.xmlrpc.XmlRpcFault: (.+$)/)
                puts error_string
                exit 2
            end

        end

        def self.enableConfigDeployment(activation_key)
        #Description:
        #    Enable configuration file deployment for the specified activation key.
        #Parameters:
        #    string key

            begin
                $a_client.call('activationkey.enableConfigDeployment', $a_key, activation_key)
            rescue XMLRPC::FaultException => e
                error_string = e.faultString.scan(/redstone.xmlrpc.XmlRpcFault: (.+$)/)
                puts error_string
                exit 2
            end

        end

        def self.getDetails(activation_key)
        #Description:
        #    Lookup an activation key's details.
        #Parameters:
        #    string key
        #Returns:
        #    struct - activation key
        #        string "key"
        #        string "description"
        #        int "usage_limit"
        #        string "base_channel_label"
        #        array "child_channel_labels"
        #            string childChannelLabel
        #        array "entitlements"
        #            string entitlementLabel
        #        array "server_group_ids"
        #            string serverGroupId
        #        array "package_names"
        #            string packageName - (deprecated by packages)
        #        array "packages"
        #            struct - package
        #                string "name" - packageName
        #                string "arch" - archLabel - optional
        #        boolean "universal_default"
        #        boolean "disabled"

            begin
                details = $a_client.call('activationkey.getDetails', $a_key, activation_key)
            rescue XMLRPC::FaultException => e
                error_string = e.faultString.scan(/redstone.xmlrpc.XmlRpcFault: (.+$)/)
                puts error_string
                exit 2
            end

            return details
        end

        def self.listAcvitatedSystems(activation_key)
        #Description:
        #    List the systems activated with the key provided.
        #Parameters:
        #    string key
        #Returns:
        #    array:
        #    struct - system structure
        #        int "id" - System id
        #        string "hostname"
        #        dateTime.iso8601 "last_checkin" - Last time server successfully checked in

            begin
                systems = $a_client.call('activationkey.listActivatedSystems', $a_key, activation_key)
            rescue XMLRPC::FaultException => e
                error_string = e.faultString.scan(/redstone.xmlrpc.XmlRpcFault: (.+$)/)
                puts error_string
                exit 2
            end

            return systems

        end
    end
    class Auth
        #Description
        #    This namespace provides methods to authenticate with the system's management server.
    
        if STDIN.respond_to?(:noecho)
            def Auth.get_password(prompt="Satellite Password: ")
                puts prompt
                STDIN.noecho(&:gets).chomp
            end
        else
            def Auth.get_password(prompt="Satellite Password: ")
                `read -s -p "#{prompt}" password; echo $password`.chomp
            end
        end

        def self.get_login_info(l_user, l_pass)
        # Obtain the login information from the user. It may have been passed as an
        # argument to the script with the -u / --username and -p / --password flags.
        # If either (or both) is missing, prompt the user for the required information.

             if l_user == nil
                puts "\nSatellite Username:"
                STDOUT.flush
                l_user = STDIN.gets.chomp
             end

             if l_pass == nil
                l_pass = Auth.get_password
                puts
             end

            if l_user == nil || l_pass == nil
                puts "You must supply login information."
                exit 1
            end

            satellite_url = "https://janus.sedata.com/rpc/api"

            $a_client = XMLRPC::Client.new2(satellite_url)
 
            return {'username' => l_user, 'password' => l_pass}

        end

        def self.login(username, password)
        #Description:
        #    Login using a username and password. Returns the session key used by most other API methods.
        #Parameters:
        #    string username
        #    string password
        #Returns:
        #    string sessionKey
    
            # Initiate login and aquire session key. Exit 1 upon login failure.
            begin
                $a_key = $a_client.call('auth.login', username, password)
            rescue XMLRPC::FaultException => e
                error_string = e.faultString.scan(/redstone.xmlrpc.XmlRpcFault: (.+$)/)
                puts error_string
                exit 1
            end
    
        end

        def self.logout()
        #Description:
        #    Logout the user with the given session key.
            
            begin
                 $a_client.call('auth.logout', $a_key)
            rescue XMLRPC::FaultException => e
                error_string = e.faultString.scan(/redstone.xmlrpc.XmlRpcFault: (.+$)/)
                puts error_string
                exit 1
            end
        end
    end

    class Api
    #Description
    #    Methods providing information about the API.

        def self.getApiCallList()
        #Description:
        #    Lists all available api calls grouped by namespace
        #Parameters:
        #    string sessionKey
        #Returns:
        #    struct - method_info
        #    string "name" - method name
        #    string "parameters" - method parameters
        #    string "exceptions" - method exceptions
        #    string "return" - method return type
            begin
                 call_list = $a_client.call('api.getApiCallList', $a_key)
            rescue XMLRPC::FaultException => e
                error_string = e.faultString.scan(/redstone.xmlrpc.XmlRpcFault: (.+$)/)
                puts error_string
                exit 1
            end
    
            return call_list
        end

        def getApiNamespaceCallList(namespace)
        #Description:
        #    Lists all available api calls for the specified namespace
        #Parameters:
        #    string namespace
        #Returns:
        #    struct - method_info
        #        string "name" - method name
        #        string "parameters" - method parameters
        #        string "exceptions" - method exceptions
        #        string "return" - method return type

            begin
                 method_info = $a_client.call('api.getApiNamespaceCallList', $a_key, namespace)
            rescue XMLRPC::FaultException => e
                error_string = e.faultString.scan(/redstone.xmlrpc.XmlRpcFault: (.+$)/)
                puts error_string
                exit 1
            end

            return method_info
        end

        #Method: getApiNamespaces
        #
        #Description:
        #Lists available API namespaces
        #Parameters:
        #string sessionKey
        #Returns:
        #
        #struct - namespace
        #string "namespace" - API namespace
        #string "handler" - API Handler
        #Method: getVersion
        #
        #Description:
        #Returns the version of the API. Since Spacewalk 0.4 (Satellie 5.3) it is no more related to server version.
        #Parameters:
        #Returns:
        #
        #string
        #Method: systemVersion
        #
        #Description:
        #Returns the server version.
        #Parameters:
        #Returns:
        #
        #string
        #
        def self.getVersion
        #Description:
        #    Returns the version of the API. Since Spacewalk 0.4 (Satellie 5.3) it is no more related to server version.
        #Returns:
        #    string
            begin
                version = $a_client.call('api.getVersion')
            rescue XMLRPC::FaultException => e
                error_string = e.faultString.scan(/redstone.xmlrpc.XmlRpcFault: (.+$)/)
                puts error_string
                exit 2
            end
            
            return version
        end
    end

    class System

        def self.listDuplicatesByHostname()
        #Description:
        #    List duplicate systems by Hostname.
        #Parameters
        #    string sessionKey
        #Returns
        #    array
        #        struct Duplicate Group
        #            string hostname
        #            array systems
        #            struct system
        #                int systemId
        #                string systemName
        #                dateTime.iso8601 last_checkin - Last time server successfully checked in
            begin
                duplicates = $a_client.call('system.listDuplicatesByHostname', $a_key)
            rescue XMLRPC::FaultException => e
                error_string = e.faultString.scan(/redstone.xmlrpc.XmlRpcFault: (.+$)/)
                puts error_string
                exit 2
            end
 
            return duplicates
        end

        class Config
            def self.addChannels(ids, channels, addToTop)
            #Description:
            #    Given a list of servers and configuration channels, this 
            #    method appends the configuration channels to either the 
            #    top or the bottom (whichever you specify) of a system's 
            #    subscribed configuration channels list. The ordering of 
            #    the configuration channels provided in the add list is 
            #    maintained while adding. If one of the configuration channels 
            #    in the 'add' list has been previously subscribed by a server, 
            #    the subscribed channel will be re-ranked to the appropriate place.
            #Parameters:
            #    array:
            #        int - IDs of the systems to add the channels to.
            #    array:
            #        string - List of configuration channel labels in the ranked order.
            #    boolean addToTop
            #        true - to prepend the given channels list to the top of the 
            #               configuration channels list of a server
            #        false - to append the given channels list to the bottom of the 
            #                configuration channels list of a server

                begin
                    $a_client.call('system.config.listFiles', $a_key, ids, channels, addToTop)
                rescue XMLRPC::FaultException => e
                    error_string = e.faultString.scan(/redstone.xmlrpc.XmlRpcFault: (.+$)/)
                    puts error_string
                    exit 2
                end

            end
            def self.createOrUpdatePath(serverID, path, isDir, info, commitToLocal)
            #Description:
            #    Create a new file (text or binary) or directory with the given path, 
            #    or update an existing path on a server.
            #Parameters:
            #    int serverId
            #    string path - the configuration file/directory path
            #    boolean isDir
            #        True - if the path is a directory
            #        False - if the path is a file
            #    struct - path info
            #        string "contents" - Contents of the file (text or base64 encoded if binary) ((only for non-directories)
            #        boolean "contents_enc64" - Identifies base64 encoded content (default: disabled, only for non-directories).
            #        string "owner" - Owner of the file/directory.
            #        string "group" - Group name of the file/directory.
            #        string "permissions" - Octal file/directory permissions (eg: 644)
            #        string "macro-start-delimiter" - Config file macro end delimiter. Use null or empty string to accept the default. (only for non-directories)
            #        string "macro-end-delimiter" - Config file macro end delimiter. Use null or empty string to accept the default. (only for non-directories)
            #        string "selinux_ctx" - SeLinux context (optional)
            #        int "revision" - next revision number, auto increment for null
            #        boolean "binary" - mark the binary content, if True, base64 encoded content is expected (only for non-directories)
            #    int commitToLocal
            #        1 - to commit configuration files to the system's local override configuration channel
            #        0 - to commit configuration files to the system's sandbox configuration channel
            #Returns:
            #    struct - Configuration Revision information
            #        string "type"
            #            file
            #            directory
            #            symlink
            #        string "path" - File Path
            #        string "target_path" - Symbolic link Target File Path. Present for Symbolic links only.
            #        string "channel" - Channel Name
            #        string "contents" - File contents (base64 encoded according to the contents_enc64 attribute)
            #        boolean "contents_enc64" - Identifies base64 encoded content
            #        int "revision" - File Revision
            #        dateTime.iso8601 "creation" - Creation Date
            #        dateTime.iso8601 "modified" - Last Modified Date
            #        string "owner" - File Owner. Present for files or directories only.
            #        string "group" - File Group. Present for files or directories only.
            #        int "permissions" - File Permissions (Deprecated). Present for files or directories only.
            #        string "permissions_mode" - File Permissions. Present for files or directories only.
            #        string "selinux_ctx" - SELinux Context (optional).
            #        boolean "binary" - true/false , Present for files only.
            #        string "md5" - File's md5 signature. Present for files only.
            #        string "macro-start-delimiter" - Macro start delimiter for a config file. Present for text files only.
            #        string "macro-end-delimiter" - Macro end delimiter for a config file. Present for text files only.

                begin
                    results = $a_client.call('system.config.createOrUpdatePath', $a_key, serverID, path, isDir, info, commitToLocal)
                rescue XMLRPC::FaultException => e
                    error_string = e.faultString.scan(/redstone.xmlrpc.XmlRpcFault: (.+$)/)
                    puts error_string
                    exit 2
                end

                return results

            end

            def self.deleteFiles(serverID, paths, deleteFromLocal)
            #Description:
            #    Removes file paths from a local or sandbox channel of a server.
            #Parameters:
            #    int serverId
            #    array:
            #        string - paths to remove.
            #    boolean deleteFromLocal
            #        True - to delete configuration file paths from the system's local override configuration channel
            #        False - to delete configuration file paths from the system's sandbox configuration channel

                begin
                    $a_client.call('system.config.deleteFiles', $a_key, serverID, paths, deleteFromLocal)
                rescue XMLRPC::FaultException => e
                    error_string = e.faultString.scan(/redstone.xmlrpc.XmlRpcFault: (.+$)/)
                    puts error_string
                    exit 2
                end
            end

            def self.listChannels(serverID)
            #Description:
            #     List all global configuration channels associated to a system in the order of their ranking.
            #Parameters:
            #    int serverId
            #Returns:
            #    array:
            #        struct - Configuration Channel information
            #            int "id"
            #            int "orgId"
            #            string "label"
            #            string "name"
            #            string "description"
            #            struct "configChannelType"
            #            struct - Configuration Channel Type information
            #                int "id"
            #                string "label"
            #                string "name"
            #                int "priority"


                begin
                    channels = $a_client.call('system.config.listChannels', $a_key, serverID)
                rescue XMLRPC::FaultException => e
                    error_string = e.faultString.scan(/redstone.xmlrpc.XmlRpcFault: (.+$)/)
                    puts error_string
                    exit 2
                end

                return channels
            end

            def self.listFiles(serverID, listLocal)
            #Description:
            #    Return the list of files in a given channel.
            #Parameters:
            #    int serverId
            #    int listLocal
            #        1 - to return configuration files in the system's local override configuration channel
            #        0 - to return configuration files in the system's sandbox configuration channel
            #Returns:
            #    array:
            #        struct - Configuration File information
            #            string "type"
            #                file
            #                directory
            #                symlink
            #            string "path" - File Path
            #            string "channel_label" - the label of the central configuration channel that has this file. Note this entry only shows up if the file has not been overridden by a central channel.
            #            struct "channel_type"
            #            struct - Configuration Channel Type information
            #                int "id"
            #                string "label"
            #                string "name"
            #                int "priority"
            #            dateTime.iso8601 "last_modified" - Last Modified Date

                begin
                    files = $a_client.call('system.config.listFiles', $a_key, serverID, listLocal)
                rescue XMLRPC::FaultException => e
                    error_string = e.faultString.scan(/redstone.xmlrpc.XmlRpcFault: (.+$)/)
                    puts error_string
                    exit 2
                end

                return files

            end

            def self.lookupFileInfo(serverID, paths, searchLocal)
            #Description:
            #    Given a list of paths and a server, returns details about the latest revisions of the paths.
            #Parameters:
            #    int serverId
            #    array:
            #        string - paths to lookup on.
            #    int searchLocal
            #        1 - to search configuration file paths in the system's local override configuration or systems subscribed central channels
            #        0 - to search configuration file paths in the system's sandbox configuration channel
            #Returns:
            #    array:
            #        struct - Configuration Revision information
            #            string "type"
            #                file
            #                directory
            #                symlink
            #            string "path" - File Path
            #            string "target_path" - Symbolic link Target File Path. Present for Symbolic links only.
            #            string "channel" - Channel Name
            #            string "contents" - File contents (base64 encoded according to the contents_enc64 attribute)
            #            boolean "contents_enc64" - Identifies base64 encoded content
            #            int "revision" - File Revision
            #            dateTime.iso8601 "creation" - Creation Date
            #            dateTime.iso8601 "modified" - Last Modified Date
            #            string "owner" - File Owner. Present for files or directories only.
            #            string "group" - File Group. Present for files or directories only.
            #            int "permissions" - File Permissions (Deprecated). Present for files or directories only.
            #            string "permissions_mode" - File Permissions. Present for files or directories only.
            #            string "selinux_ctx" - SELinux Context (optional).
            #            boolean "binary" - true/false , Present for files only.
            #            string "md5" - File's md5 signature. Present for files only.
            #            string "macro-start-delimiter" - Macro start delimiter for a config file. Present for text files only.
            #            string "macro-end-delimiter" - Macro end delimiter for a config file. Present for text files only.

                begin
                    info = $a_client.call('system.config.lookupFileInfo', $a_key, serverID, paths, searchLocal)
                rescue XMLRPC::FaultException => e
                    error_string = e.faultString.scan(/redstone.xmlrpc.XmlRpcFault: (.+$)/)
                    puts error_string
                    exit 2
                end

                return info

            end
        end

        class Search
        #Description
        #    Provides methods to perform system search requests using the search server.
        #Available methods
        #    deviceDescription
        #    deviceDriver
        #    deviceId
        #    deviceVendorId
        #    hostname
        #    ip
        #    nameAndDescription
        #    uuid

            def self.hostname(host)
            #
            #Description:
            #    List the systems which match this hostname
            #Parameters:
            #    string sessionKey
            #    string searchTerm
            #Returns:
            #    array:
            #        struct - system
            #            int "id"
            #            string "name"
            #            dateTime.iso8601 "last_checkin" - Last time server successfully checked in
            #            string "hostname"
            #            string "ip"
            #            string "hw_description" - hw description if not null
            #            string "hw_device_id" - hw device id if not null
            #            string "hw_vendor_id" - hw vendor id if not null
            #            string "hw_driver" - hw driver if not null
            begin
                system_list = $a_client.call('system.search.hostname', $a_key, host)
            rescue XMLRPC::FaultException => e
                error_string = e.faultString.scan(/redstone.xmlrpc.XmlRpcFault: (.+$)/)
                puts error_string
                exit 2
            end

            return system_list

            end

            def self.listSystems()
            #Description:
            #    Returns a list of all servers visible to the user.
            #Returns:
            #    array:
            #        struct - system
            #            int "id"
            #            string "name"
            #            dateTime.iso8601 "last_checkin" - Last time server successfully checked in

                begin
                    system_list = $a_client.call('system.listSystems', $a_key)
                rescue XMLRPC::FaultException => e
                    error_string = e.faultString.scan(/redstone.xmlrpc.XmlRpcFault: (.+$)/)
                    puts error_string
                    exit 2
                end

                return system_list
            end
        end
    end
end
