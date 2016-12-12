extends Node

var I = preload("res://scripts/item.gd")


onready var shovel = I.new("shovel","A big shovel","Can make biiiig holes.","res://images/shovel_inv.png")
onready var rope = I.new("rope","A rope","Can be used for a lot of purposes","res://images/rope_inv.png")
onready var skull = I.new("skull","A weird skull",["Can you hear me?","Well, do ya\u2019 talk out loud?"] ,"res://images/skull_inv.png")
onready var bad_hook = I.new("bad_hook","An unusable metal hook","That\u2019s supposed to be some sort of hook. All bent out of shape. No use for me like this, but I can try to restore it.","res://images/bad_hook_inv.png")
onready var hook = I.new("hook","A repaired metal hook","Now it is looking much better.","res://images/hook_inv.png")
onready var sharpening_rock = I.new("sharpening_rock","Two rocks","They can be used for metalworking","res://images/small_rocks_inv.png")
onready var grappling_hook = I.new("grappling_hook","A selfmade grappling hook","I wonder if I can pull myself somewhere.","res://images/grappling_hook_inv.png")
onready var artifact_1 = I.new("artifact_1","A mysterious thing","It looks like it isn't complete.","res://images/artifact_1_inv.png")
onready var metal_door = I.new("metal_door","A big and heavy steel door.","Part of an old steel door. Corrosion gave it the rest. But it\u2019s still strong. Might do some damage.","res://images/metal_door.png")
onready var gummy_worms = I.new("gummy_worms","Common gummy worms","They almost look like real worms.","res://images/gummy_worms_inv.png")
onready var chainsaw = I.new("chainsaw","A chainsaw","A chainsaw without fuel. Not much use like this.","res://images/chainsaw_inv.png")
onready var chainsaw_handle = I.new("chainsaw_handle","A chainsaw handle","A chainsaw handle. It provides excellent grip.","res://images/chainsaw_handle_inv.png")
onready var fuel_can = I.new("fuel_can","A gas can.","A red gas canister with a warning label: \u201cFor chainsaws only!\u201d. It's empty.","res://images/fuel_can_inv.png")
onready var dull_blade = I.new("dull_blade","A dull blade","This could be used as a blade, if it had a handle.","res://images/dull_blade_inv.png")
onready var dull_machete = I.new("dull_machete","A dull machete","I could chop down some plants with it, if it wasn't so dull.","res://images/dull_machete_inv.png")
onready var machete = I.new("machete","A sharp machete","Die plants, die!","res://images/machete_inv.png")

onready var artifact_2 = I.new("artifact_2","An even more mysterious thing","This looks like it would fit into the other one.","res://images/artifact_2_inv.png")

onready var artifact_3 = I.new("artifact_3","A completed artifact","It is completed!","res://images/artifact_3_inv.png")