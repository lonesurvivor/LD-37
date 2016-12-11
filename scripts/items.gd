extends Node

var I = preload("res://scripts/item.gd")


onready var shovel = I.new("shovel","Big Shovel","Can make biiiig holes.","res://images/shovel_inv.png")
onready var rope = I.new("rope","A rope","Can be used for a lot of purposes","res://images/ph.png")
onready var skull = I.new("skull","A weird skull","???","res://images/ph.png")
onready var bad_hook = I.new("bad_hook","An unusable metal hook","???","res://images/ph.png")
onready var hook = I.new("hook","A repaired hook","???","res://images/inv_grappling_hook.png")
onready var sharpening_rock = I.new("sharpening_rock","A sharpening rock","???","res://images/ph.png")
onready var grappling_hook = I.new("grappling_hook","Selfmade grappling hook","Use it to pull yourself.","res://images/inv_grappling_hook.png")
onready var artifact_1 = I.new("artifact_1","A mysterious thing","It looks like it isn't complete.","res://images/ph.png")

onready var metal_door = I.new("metal_door","A big and heavy metal door.","Useless. ... Useless?","res://images/ph.png")
onready var gummy_worms = I.new("gummy_worms","Common gummy worms","They almost look like real worms.","res://images/ph.png")
onready var chainsaw = I.new("chainsaw","Chainsaw","Chainsaw","res://images/ph.png")
onready var chainsaw_handle = I.new("chainsaw_handle","Chainsaw Handle","Chainsaw Handle","res://images/ph.png")
onready var fuel_can = I.new("fuel_can","A fuel can.",["Nice!", "Oh, it's empty"],"res://images/ph.png")
onready var dull_blade = I.new("dull_blade","A dull blade","bla","res://images/ph.png")
onready var blade = I.new("blade","A sharp blade","bla","res://images/ph.png")
onready var machete = I.new("machete","A Machete","bla","res://images/ph.png")

onready var artifact_2 = I.new("artifact_2","A even more mysterious thing","bla","res://images/ph.png")