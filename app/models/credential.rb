class Credential < ApplicationRecord
  enum :access, [:seller, :buyer]

  def self.create_access(access)
    raise "Invalid Access" if !Credential.accesses.keys.map(&:to_sym).include?(access)
    create! access: access, key: SecureRandom.base64(20)
  end
end
