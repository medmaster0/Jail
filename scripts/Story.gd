extends Node

func generateName():
	var consonants = "bcdfghjklmnpqrstvwxyz"
	var vowels = "aeiou"
	
	var temp_name = "" #the string we'll be returning
	var temp_char = "" #temporary character to store the char we'll be appending
	
	# ADD A CONSONANT
	temp_char = consonants[randi()%consonants.length()]
	temp_name = temp_name + temp_char
	
	#ADD A VOWEL
	temp_char = vowels[randi()%vowels.length()]
	temp_name = temp_name + temp_char	
	
	# ADD A CONSONANT (TWICE)
	temp_char = consonants[randi()%consonants.length()]
	temp_name = temp_name + temp_char
	temp_name = temp_name + temp_char
	
	#ADD A VOWEL
	temp_char = vowels[randi()%vowels.length()]
	temp_name = temp_name + temp_char	

	print(temp_name)