#!bin/bash

echo ""
read -p "Generate upgrade list? (y/n)?:" conf
echo ""
if [ "$conf" = "y" ]; then
    eval sudo apt-get dist-upgrade --print-uris -qq | cut -d\' -f2 >> upgrades.list;
    echo "done (in filename:'upgrades.list')";
    echo ""
else
    echo "Ok. I got you, I won't generate list";
    echo ""
    fi
        
read -p "Package download script? (y/n):" conf2
if [ "$conf2" = "y" ]; then
    	read -p "packagename: " pkg
	eval sudo apt-get install $pkg --print-uris -qq | cut -d\' -f2 >> pkglist.list;
	echo ""
	echo "done (in filename:'pkglist.list')";
else
    	echo ""
    	echo "Okey, I heard you!";
exit 0
fi
   
	echo ""
