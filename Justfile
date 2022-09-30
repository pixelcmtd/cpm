test:
        rm -rf .craftos/computer
        mkdir -p .craftos/computer/0
        cp cpm.lua .craftos/computer/0/cpm
        craftos -c --directory .craftos
