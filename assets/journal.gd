extends Node2D

var list_feuille
@onready var list_titre = [$Titre1,$Titre2, $Titre3, $Titre4, $Titre5, $Titre6]


func update_liste_feuille(list_feuille_du_controller):
	list_feuille = list_feuille_du_controller
	print(list_feuille )

func update_texte():
	
	for i in range(list_feuille.size()):
		print(list_feuille[i])
		var text = list_feuille[i].get_journal_text()
		list_titre[i].text = text
	pass
