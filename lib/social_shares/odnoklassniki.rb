module SocialShares
  class Odnoklassniki < MailRu
    def shares!
      response["share_ok"].to_i
    end
  end
end
