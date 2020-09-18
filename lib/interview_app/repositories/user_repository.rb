class UserRepository < Hanami::Repository
  associations do
    has_many :posts
  end

  def already_exist?(login)
    users.where({ login: login }).limit(1).map_to(User).one
  end

  def find_ip_list
    sql_query = <<~SQL
      SELECT t2.ip, t2.login FROM (SELECT u.ip, count(login) as count FROM users u
        GROUP BY u.ip HAVING count(*) > 1) t1 join users t2 on t1.ip = t2.ip ORDER BY ip DESC
    SQL
    raw_list = users.read(sql_query)
    sorted_list = raw_list
                  .map { |i| { i[:ip] => i[:login] } }
                  .group_by { |i| i.keys.first }
    sorted_list.map do |k, v|
      flatten_value = v.map(&:values).flatten
      Hash[k, flatten_value]
    end
  end
end
