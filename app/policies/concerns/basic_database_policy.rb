module BasicDatabasePolicy
  def index?
    true
  end

  def show?
    true
  end

  def new?
    true
  end

  def create?
    true
  end

  def edit?
    true
  end

  def update?
    user.roles.any? { |role| role.name.eql? "admin" }
  end

  def destroy?
    true
  end
end
