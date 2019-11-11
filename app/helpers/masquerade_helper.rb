module MasqueradesHelper
  def account_masquerade(current_account)
    link_to "Logged in as \#{current_account.name}. Go back.", back_masquerade_path(current_account), class: "fixed bottom-0 right-0 mr-4 px-4 py-2 bg-gray-800 text-white rounded-t"
  end
end