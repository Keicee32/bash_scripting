#!/usr/bin/bash

catNumbers=""

homepage() {
	echo "Welcome to our App \n What will you like to do today?"
	echo -e "1) Open an account \n2) Logout "
	read -p "Choose an option: " open
}
homepage

generateRandomNumbers() {
	lengthOfRandomNumbers=5

	# Generates 5 different random numbers. Seq is a command meaning sequence
	for n in `seq "$lengthOfRandomNumbers"`
	do
		randomNumber=$(shuf -i 10-100 -n1) #The shuf command works the same way as $RANDOM to generate random numbers
		catNumbers+="${randomNumber}"	
	done
}

generateRandomNumbers

show_details() {
	#accountNumber=${generateRandomNumbers}
	echo -e "Your details are \n First name: $first_name \n Last name: $last_name \n Account number: $catNumbers"
}

send_mail() {
#<<<<<<< HEAD
	touch mail_contents.txt
	#echo "Subject: Your Bank details and new account number" > mail_contents.txt
	#result="$(show_details)"
	#echo $result >> mail_contents.txt 
	#ssmtp $1 < ./mail_contents.txt
#=======
	echo -e "$(show_details)" | mutt -s "Your Bank Details and New Account Number" -- $email
	#ssmtp $1 < ./mail_contents.txt 
#>>>>>>> b2c1d2a9b850eb600c8ad31f5fd2ecdbcdc106ea
}

openaccount() {
	echo -e "Welcome! Please fill in the following details"
	read -p "First Name: " first_name
	read -p "Last name: " last_name
	read -p "BVN: " bvn
	
	bvnregex=[[:digit:]]{11}
	#verify BVN contains only digits and is 11 digits long
	until [[ $bvn =~ $bvnregex ]] && [[ ${#bvn} == 11 ]]
	do
	
	if [[ $bvn =~ [^[:digit:]] ]]
	then
	echo "BVN should contain only numbers"
	read -p "Please enter your correct BVN: " bvn
	
	elif [[ ${#bvn} -lt 11 ]]
	then
	echo "BVN less than 11 digits"
	read -p "Please enter your correct BVN: " bvn
	
	elif [[ ${#bvn} -gt 11 ]]
	then
	echo "BVN greater than 11 digits"
	read -p "Please enter your correct BVN: " bvn
	fi
	done
	###

	read -p "Email: " email
	#verify email pattern with regex
	regex=[[:alnum:]]+@[[:alnum:]]+\.[[:alpha:]]{2,4}
	until [[ $email =~ $regex ]]
	do
	read -p "Enter a valid email address: " email
	done

	###
	send_mail $email

	 echo -e "\nThank you. A copy of your account details has been sent to your email address. \nWould you like to see your details? \nyes: \nno:" 
	 read -p "response: " details

	 if [[ $details == "yes" ]]; then
		 show_details
	 else
		 homepage
	 fi

}


if [[ $open == '1' ]]; then
	openaccount
else
	exit
fi
