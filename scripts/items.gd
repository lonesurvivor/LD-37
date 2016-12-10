extends Node

var I = preload("res://scripts/item.gd")

onready var chainsaw = I.new("a","Chainsaw Number 1","Kill kill kill","res://images/inv_chainsaw.png")
onready var chainsaw2 = I.new("b","Chainsaw Number 2","Kill kill kill","res://images/inv_chainsaw.png")
onready var grappling_hook = I.new("grappling_hook","Selfmade grappling hook","Use it to pull yourself.","res://images/inv_grappling_hook.png")