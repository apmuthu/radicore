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
	echo -n "DROP FUNCTION make_set(bigint, ";
	arg $i
	echo ");"
	i=$[$i + 1];
done
