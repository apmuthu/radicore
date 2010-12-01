arr()
{
	l=$1
	j=1;
	found=0;
	echo -n "a = ARRAY["
	while [ $j -le $l ]
	do
		if [ $found -eq 0 ]
		then
			found=1;
		else
			echo -n ", "
		fi
		echo -n "\$"
		echo -n $[$j + 1]
		j=$[$j + 1]
	done
	echo "];"
}

arg()
{
	l=$1
    j=1;
    found=0;
    while [ $j -le $l ]
    do
        if [ $found -eq 0 ]
        then
            found=1;
        else
            echo -n ", "
        fi
		echo -n "text"
        j=$[$j + 1]
    done
}

i=1
while [ $i -lt 32 ]
do
	echo -n "CREATE OR REPLACE FUNCTION make_set(bigint, ";
	arg $i
	echo ")"
	echo "RETURNS text AS \$\$"
	echo "  DECLARE"
	echo "    a text[];"
	echo "  BEGIN"
	echo -n "    ";
	arr $i
	echo "RETURN _make_set(\$1, a);"
	echo "END;"
	echo "\$\$ IMMUTABLE STRICT LANGUAGE PLPGSQL;"
	echo ""
	i=$[$i + 1];
done
