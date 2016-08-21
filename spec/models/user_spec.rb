# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  nom        :string
#  email      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe User do

  before(:each) do
    @attr = {
      :nom => "Utilisateur exemple",
      :email => "user@example.com",
      :password => "foobar",
      :password_confirmation => "foobar"
    }
  end

  it "devrait créer une nouvelle instance dotée des attributs valides" do
    User.create!(@attr)
  end

  it "exige un nom" do
    bad_guy = User.new(@attr.merge(:nom => ""))
    expect(bad_guy).not_to be_valid
  end
  
  it "exige une adresse email" do
    no_email_user = User.new(@attr.merge(:email => ""))
    expect(no_email_user).not_to be_valid
  end
  
  it "devrait rejeter les noms trop longs" do
    long_nom = "a" * 51
    long_nom_user = User.new(@attr.merge(:nom => long_nom))
    expect(long_nom_user).not_to be_valid
  end
  
   it "devrait accepter une adresse email valide" do
    adresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
    adresses.each do |address|
      valid_email_user = User.new(@attr.merge(:email => address))
      expect(valid_email_user).to be_valid
    end
  end

  it "devrait rejeter une adresse email invalide" do
    adresses = %w[user@foo,com user_at_foo.org example.user@foo.]
    adresses.each do |address|
      invalid_email_user = User.new(@attr.merge(:email => address))
      expect(invalid_email_user).not_to be_valid
    end
  end
  
  it "devrait rejeter un email double" do
    # Place un utilisateur avec un email donné dans la BD.
    User.create!(@attr)
    user_with_duplicate_email = User.new(@attr)
    expect(user_with_duplicate_email).not_to be_valid
  end
  
  it "devrait rejeter une adresse email invalide jusqu'à la casse" do
    upcased_email = @attr[:email].upcase
    User.create!(@attr.merge(:email => upcased_email))
    user_with_duplicate_email = User.new(@attr)
    expect(user_with_duplicate_email).not_to be_valid
  end
  
  describe "password validations" do

    it "devrait exiger un mot de passe" do
      expect(User.new(@attr.merge(:password => "", :password_confirmation => ""))).
        not_to be_valid
    end

    it "devrait exiger une confirmation du mot de passe qui correspond" do
      expect(User.new(@attr.merge(:password_confirmation => "invalid"))).
        not_to be_valid
    end

    it "devrait rejeter les mots de passe (trop) courts" do
      short = "a" * 5
      hash = @attr.merge(:password => short, :password_confirmation => short)
      expect(User.new(hash)).not_to be_valid
    end

    it "devrait rejeter les (trop) longs mots de passe" do
      long = "a" * 41
      hash = @attr.merge(:password => long, :password_confirmation => long)
      expect(User.new(hash)).not_to be_valid
    end
  end
  describe "password encryption" do

    before(:each) do
      @user = User.create!(@attr)
    end

    it "devrait avoir un attribut  mot de passe crypté" do
      expect(@user).to respond_to(:encrypted_password)
    end
	
	it "devrait définir le mot de passe crypté" do
      expect(@user.encrypted_password).not_to be_blank
    end
    describe "Méthode has_password?" do

      it "doit retourner true si les mots de passe coïncident" do
        expect(@user.has_password?(@attr[:password])).to be true
      end    

      it "doit retourner false si les mots de passe divergent" do
        expect(@user.has_password?("invalide")).to be false
      end 
    end
	describe "authenticate method" do

      it "devrait retourner nul en cas d'inéquation entre email/mot de passe" do
        wrong_password_user = User.authenticate(@attr[:email], "wrongpass")
        expect(wrong_password_user).to be nil
      end

      it "devrait retourner nil quand un email ne correspond à aucun utilisateur" do
        nonexistent_user = User.authenticate("bar@foo.com", @attr[:password])
        expect(nonexistent_user).to be nil
      end

      it "devrait retourner l'utilisateur si email/mot de passe correspondent" do
        matching_user = User.authenticate(@attr[:email], @attr[:password])
        expect(matching_user).to eq(@user)
      end
    end
  end
end
