class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.admin?
      can :manage, :all
    elsif user.hotel?
      can :manage, Hotel, :user => user
      can :manage, HotelPhoto, :hotel => {:user => user}
      can :manage, Promotion, :hotel => {:user => user}
      can :manage, Room, :hotel => {:user => user}
      can :manage, RoomPhoto, :hotel => {:user => user}
    end
  end
end