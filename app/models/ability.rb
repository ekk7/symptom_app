class Ability
  include CanCan::Ability

  def initialize(user)
    can :manage, Symptom, user_id: user.id
  end
end
