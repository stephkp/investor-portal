module ApplicationHelper
  def masked_ssn(ssn)
    return '---' if ssn.blank?
    ssn.gsub(/(\d{3})-(\d{2})-(\d{4})/, '\1-XX-\3')
  end
end