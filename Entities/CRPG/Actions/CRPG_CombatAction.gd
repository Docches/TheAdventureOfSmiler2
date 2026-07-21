extends Resource
class_name CRPG_CombatAction

enum TargetType {
	SELF,
	SINGLE_ALLY,
	SINGLE_ENEMY,
	MULTI_ENEMIES,
	ALL_ALLIES,
	ALL_ENEMIES,
	EVERYONE
}

@export_group("Info")
@export var name: String
@export_multiline var description: String
@export var icon: Texture2D

@export_group("Cost")
@export var mana_cost := 0
@export var cooldown := 0
@export_range(0.0, 1.0)
var accuracy := 1.0

@export_group("Target")
@export var target_type := TargetType.SINGLE_ENEMY

# One entry per target.
# Each target has a list of [Effect, power]
@export var targets_effects: Array[CRPG_TargetEffects]


func execute(user, targets: Array):
	for i in range(min(targets.size(), targets_effects.size())):
		var target = targets[i]

		for effect_data in targets_effects[i].effects:
			match effect_data.effect:
				CRPG_CombatEffect.Effect.DAMAGE_PHYSICAL:
					target.take_damage(max(1, user.atk + effect_data.power - target.armor))

				CRPG_CombatEffect.Effect.DAMAGE_MAGICAL:
					target.take_damage(max(1, user.magic + effect_data.power - target.magic_resistance))

				CRPG_CombatEffect.Effect.HEAL:
					target.heal(effect_data.power)

				CRPG_CombatEffect.Effect.BUFF_ATK:
					target.modify_atk(effect_data.power)

				CRPG_CombatEffect.Effect.BUFF_ARMOR:
					target.modify_armor(effect_data.power)

				CRPG_CombatEffect.Effect.BUFF_MAGIC:
					target.modify_magic(effect_data.power)

				CRPG_CombatEffect.Effect.BUFF_MAGIC_RESIST:
					target.modify_magic_resistance(effect_data.power)

				CRPG_CombatEffect.Effect.BUFF_SPEED:
					target.modify_speed(effect_data.power)

				CRPG_CombatEffect.Effect.BUFF_ACCURACY:
					target.modify_accuracy(effect_data.power)

				CRPG_CombatEffect.Effect.BUFF_CRIT:
					target.modify_crit(effect_data.power)

				CRPG_CombatEffect.Effect.DEBUFF_ATK:
					target.modify_atk(-effect_data.power)

				CRPG_CombatEffect.Effect.DEBUFF_ARMOR:
					target.modify_armor(-effect_data.power)

				CRPG_CombatEffect.Effect.DEBUFF_MAGIC:
					target.modify_magic(-effect_data.power)

				CRPG_CombatEffect.Effect.DEBUFF_MAGIC_RESIST:
					target.modify_magic_resistance(-effect_data.power)

				CRPG_CombatEffect.Effect.DEBUFF_SPEED:
					target.modify_speed(-effect_data.power)

				CRPG_CombatEffect.Effect.DEBUFF_ACCURACY:
					target.modify_accuracy(-effect_data.power)

				CRPG_CombatEffect.Effect.DEBUFF_CRIT:
					target.modify_crit(-effect_data.power)

				CRPG_CombatEffect.Effect.POISON:
					target.add_status("Poison", effect_data.power)

				CRPG_CombatEffect.Effect.BURN:
					target.add_status("Burn", effect_data.power)

				CRPG_CombatEffect.Effect.FREEZE:
					target.add_status("Freeze", effect_data.power)

				CRPG_CombatEffect.Effect.PARALYZE:
					target.add_status("Paralyze", effect_data.power)

				CRPG_CombatEffect.Effect.SLEEP:
					target.add_status("Sleep", effect_data.power)

				CRPG_CombatEffect.Effect.BLEED:
					target.add_status("Bleed", effect_data.power)

				CRPG_CombatEffect.Effect.STUN:
					target.add_status("Stun", effect_data.power)

				CRPG_CombatEffect.Effect.SILENCE:
					target.add_status("Silence", effect_data.power)

				CRPG_CombatEffect.Effect.CONFUSE:
					target.add_status("Confuse", effect_data.power)

				CRPG_CombatEffect.Effect.RESTORE_MANA:
					target.restore_mana(effect_data.power)

				CRPG_CombatEffect.Effect.DRAIN_MANA:
					target.drain_mana(effect_data.power)

				CRPG_CombatEffect.Effect.CUSTOM:
					custom_effect(user, target, effect_data.power)


func custom_effect(user, target, power):
	pass
