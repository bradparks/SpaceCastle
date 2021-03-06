package ;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;

/**
 * @author galoyo
 */

class NpcDogLady extends FlxSprite
{
	private var _startx:Float;
	private var _starty:Float;
	
	private var _allDogsFound:Bool = false;
	private var _receivedSuperBlock:Bool = false;
	private var ticks:Float = 0;
		
	public function new(x:Float, y:Float) 
	{		
		super(x, y);

		_startx = x;
		_starty = y;	
	
		loadGraphic("assets/images/npcHumanF01.png", true, Reg._tileSize, Reg._tileSize);

		animation.add("idle", [0]);
		animation.play("idle");

	}
	
	override public function update(elapsed:Float):Void 
	{				
		if (isOnScreen())
		{					
			if ( Reg._dogCarriedItsID.length == 0)
			{				
				//############### PLAYER CHATS WITH NPC ###############
				if( overlapsAt(x, y, Reg.state.player))
				{
					
					if (FlxG.keys.anyJustPressed(["DOWN"]) && Reg._itemGotDogFlute == false || Reg._mouseClickedButtonDown == true && Reg._itemGotDogFlute == false)
					{				
						if(Reg.mapXcoords == 15 && Reg.mapYcoords == 15)	
						{
							Reg.dialogIconFilename = "";
							Reg.dialogIconText = openfl.Assets.getText("assets/text/Map15-15A-dogLady.txt").split("#");
											
							Reg.dialogCharacterTalk[0] = "talkDogLady.png";
									
							// see the top part of npcMalaUnhealthy.hx update to see how this yes/no question works when answered.
							Reg.displayDialogYesNo = true;
							Reg._dialogAnsweredYes = false;
							Reg._dialogYesNoWasAnswered = false;
							Reg.state.openSubState(new Dialog());							
						}
					} 
					
					else if (Reg._itemGotDogFlute == false && Reg._displayFluteDialog == true && Reg.dialogCharacterTalk[0] == "talkDogLady.png" && Reg._dialogYesNoWasAnswered == true && Reg._dialogAnsweredYes == true)	// old lady gave the dog flute to player.
					{
						// old lady gave the dog flute to player.
						if(Reg.mapXcoords == 15 && Reg.mapYcoords == 15)		
						{
							if (Reg._soundEnabled == true) FlxG.sound.play("pickup", 1, false);
							
							Reg.dialogIconFilename = "itemDogFlute.png";
							Reg.dialogIconText = openfl.Assets.getText("assets/text/touchItemDogFlute.txt").split("#");
						
							Reg.state.newInventoryItem( openfl.Assets.getText("assets/text/touchItemDogFluteDescription.txt"), Reg.dialogIconFilename);
							Reg.dialogCharacterTalk[0] = "";
							Reg.displayDialogYesNo = false;
							Reg.state.openSubState(new Dialog());				
							Reg._itemGotDogFlute = true;
							Reg._displayFluteDialog = false;
						}
					}
					else if (Reg._itemGotDogFlute == true && Reg._displayFluteDialog == false && Reg.dialogIconFilename == "itemDogFlute.png")
					{
						if(Reg.mapXcoords == 15 && Reg.mapYcoords == 15)		
						{
							Reg.dialogIconFilename = "";
							Reg.dialogIconText = openfl.Assets.getText("assets/text/Map15-15Yes-dogLady.txt").split("#");
															
							Reg.dialogCharacterTalk[0] = "talkDogLady.png";
							Reg.displayDialogYesNo = false;
							Reg.state.openSubState(new Dialog());
						}
					}
					
					else if (FlxG.keys.anyJustPressed(["DOWN"]) && Reg._itemGotDogFlute == true || Reg._mouseClickedButtonDown == true && Reg._itemGotDogFlute == true)
					{				
						if(Reg.mapXcoords == 15 && Reg.mapYcoords == 15)		
						{
							Reg.dialogIconFilename = "";
							Reg.dialogIconText = openfl.Assets.getText("assets/text/Map15-15Yes-dogLady.txt").split("#");
											
							Reg.dialogCharacterTalk[0] = "talkDogLady.png";
							Reg.displayDialogYesNo = false;
							Reg.state.openSubState(new Dialog());
						}
					} 
					
				}
			}			
			//###################### END CHAT #####################
			
			if (FlxG.keys.anyJustPressed(["DOWN"]) && Reg._itemGotDogFlute == true && overlapsAt(x, y, Reg.state.player)
			|| Reg._mouseClickedButtonDown == true && Reg._itemGotDogFlute == true && overlapsAt(x, y, Reg.state.player))
			{			
				if ( Reg._dogCarriedItsID.length == 2)
				{				
					if(Reg.mapXcoords == 15 && Reg.mapYcoords == 15)		
					{
						Reg.dialogIconFilename = "";
						Reg.dialogIconText = openfl.Assets.getText("assets/text/Map15-15B-dogLady.txt").split("#");
										
						Reg.dialogCharacterTalk[0] = "talkDogLady.png";
						Reg.displayDialogYesNo = false;
						Reg.state.openSubState(new Dialog());
						Reg._dialogAnsweredYes = false;
					}
				} 
		
				else if ( Reg._dogCarriedItsID.length == 4 && _allDogsFound == false)
				{				
					if(Reg.mapXcoords == 15 && Reg.mapYcoords == 15)		
					{
						Reg.dialogIconFilename = "";
						Reg.dialogIconText = openfl.Assets.getText("assets/text/Map15-15C-dogLady.txt").split("#");
										
						Reg.dialogCharacterTalk[0] = "talkDogLady.png";							
						Reg.displayDialogYesNo = false;
						Reg.state.openSubState(new Dialog());
						_allDogsFound = true;
					}
				}				
				 	

			} 
			
			if ( Reg._dogCarriedItsID.length == 0)
			{
				if (Reg.displayDialogYesNo == true && Reg._dialogYesNoWasAnswered == true && Reg._dialogAnsweredYes == true)
				{						
					Reg._itemGotDogFlute = true;
				}	
			}
			
			if ( Reg._dogCarriedItsID.length == 0 && Reg._itemGotSuperBlock[2] == false)
			{
				if (Reg.displayDialogYesNo == true && Reg._dialogYesNoWasAnswered == true && Reg._dialogAnsweredYes == false && overlapsAt(x, y, Reg.state.player))
				{						
					Reg.dialogIconText = openfl.Assets.getText("assets/text/Map15-15No-dogLady.txt").split("#");
					
					Reg.dialogCharacterTalk[0] = "talkDogLady.png";	
					Reg.displayDialogYesNo = false;
					Reg.state.openSubState(new Dialog());
					_receivedSuperBlock = false;							
					Reg._playerHasTalkedToThisMob = false;
				}	
			}
			
			if ( Reg._dogCarriedItsID.length == 4 && Reg._itemGotSuperBlock[2] == false && _allDogsFound == true)
			{				
				if (ticks >= 1 && ticks < 5)
				{
					if(Reg.mapXcoords == 15 && Reg.mapYcoords == 15)		
					{
						Reg.dialogIconFilename = "";
						Reg.dialogCharacterTalk[0] = "talkDogLady.png";	
				
						Reg.dialogIconFilename = "itemSuperBlock2.png";
						Reg.dialogIconText = openfl.Assets.getText("assets/text/touchItemSuperBlock2.txt").split("#");
														
						Reg.dialogCharacterTalk[0] = "";
							
						Reg.displayDialogYesNo = false;
						Reg.state.openSubState(new Dialog());		
					
						Reg._itemGotSuperBlock[2] = true;
						_receivedSuperBlock = true;
						_allDogsFound = false;
						if (Reg._soundEnabled == true) FlxG.sound.play("pickup", 1 , false);
					}
				}
				ticks = Reg.incrementTicks(ticks, 60 / Reg._framerate);
				if (ticks > 100000) ticks = 0;
			}	
				
			super.update(elapsed);			
		}
	}
	
}