class Sale < ActiveRecord::Base

  # AR Scope (aka Class Methods)
  def self.active # the 'self.' part makes it a Class Method
    where("sales.starts_on <= ? AND sales.ends_on >= ?", Date.current, Date.current)
  end
  def finished?
    ends_on < Date.current
  end

  def upcoming?
  starts_on > Date.current
  end

  def active?
    !upcoming? && !finished?
  end
end
