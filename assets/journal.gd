extends Node2D

var list_feuille = {}
@onready var list_titre = [$Titre1,$Titre2, $Titre3, $Titre4, $Titre5, $Titre6]


func update_liste_feuille(list_feuille_du_controller):
	list_feuille = list_feuille_du_controller

func update_texte():
	
	for i in list_feuille:
		var text = list_feuille[i].get_journal_texte()
		list_titre[i].text = text
	pass
