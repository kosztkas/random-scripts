# name resolving trick, inserts the address into curl's DNS cache, no need for hosts file edition (+ verbose, header only, no cert verification)
curl https://example.com --resolve example.com:443:1.2.3.4 -vIk
