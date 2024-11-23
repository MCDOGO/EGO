extends Resource

class_name Weapon_Animation

@export_flags("Hand Move:1", "Attachment Move:2", "Gun Move:4") var animation_type : int
@export var eject : bool = false
@export var holdMag : bool = false

@export_group("Hand")
## Hands
@export var leftHandTo : Vector2
@export var leftHandRotLock : bool
@export var leftHandRotation : int
@export var leftHandAnim: int

@export var rightHandTo : Vector2
@export var rightHandRotLock : bool
@export var rightHandRotation : int
@export var rightHandAnim: int 

@export var HlinearOrCubic : bool = true ## True for cubic
@export var HreverseCubic : bool = false ## Cubic in the opposite direction


@export_group("Attachment")
## Attachment
@export var attachmentIndex : int
@export var attachmentTo : Vector2

@export var AlinearOrCubic : bool = true ## True for cubic
@export var AreverseCubic : bool = false ## Cubic in the opposite direction

@export var attachmentHide : bool = false ## Hides the attachment

@export_group("Gun")
## Gun
@export var gunPositionOffset : Vector2
@export var gunRotation : int
@export var backToRest : bool

@export var gunOnSide : bool = false
@export var flipGun : bool = false
@export var flipSpriteOffset : Vector2

@export var GlinearOrCubic : bool = true ## True for cubic
@export var GreverseCubic : bool = false ## Cubic in the opposite direction


@export_group("Other")
## Other
@export var duration : float
@export var playNextAnim : bool = false
@export var durationUntilNext : float ## Needs to be less than duration


@export_group("Eject")
## Eject
@export_file("*.png") var fodder
@export var position : Vector2
@export var direction : int


@export_group("Hold Mag")
## Hold Magazine
@export_file("*.png") var magazine
@export var removeMag : bool = false
@export var LeftOrRight : bool = false ## False for left
@export var magRotation : int = 0 ## Added to hand rotation
