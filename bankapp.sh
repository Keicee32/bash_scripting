#!/usr/bin/bash

homepage() {
	echo "Welcome to our App \n What will you like to do today?"
	echo -e "1) Open an account \n2) Logout "
	read -p "Choose an option: " open
}
homepage

show_details() {
	echo -e "Your details are \n First name: $first_name \n Last name: $last_name \n Account number: 0143123456"
}

send_mail() {
	echo -e "$(show_details)" | mutt -s "Your Bank Details and New Account Number" -- $email
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
