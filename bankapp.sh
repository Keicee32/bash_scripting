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
	touch mail_contents.txt
	echo "Subject: Your Bank details and new account number" > mail_contents.txt
	result="$(show_details)"
	echo $result >> mail_contents.txt 
	ssmtp $1 < /home/vagrant/Document/bash_scripting_files/mail_contents.txt
}

openaccount() {
	echo -e "Welcome! Please fill in the following details"
	read -p "First Name: " first_name
	read -p "Last name: " last_name
	read -p "BVN: " bvn

	while [[ $bvn -lt 11 ]]
	do
		read -p "BVN: " bvn
	done

	read -p "Email: " email
	send_mail $email

	 echo -e "\nThank you. A copy of your account details has been sent to your email address. \nWould you like to see your details? \nYes: \nNo:" 
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
