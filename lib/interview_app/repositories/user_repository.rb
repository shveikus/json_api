class UserRepository < Hanami::Repository
  associations do
    has_many :posts
  end

  def already_exist?(login)
    users.where({ login: login }).limit(1).map_to(User).one
  end

  def find_ip_list
    raw_list = users.read('select t2.ip, t2.login from (select u.ip, count(login) as count from users u group by u.ip HAVING count(*) > 1) t1 join users t2 on t1.ip = t2.ip ORDER BY ip DESC')
    sorted_list = raw_list.map { |i| { i[:ip] => i[:login] } }.group_by { |i| i.keys.first }
    sorted_list.map do |k, v|
      v.map!(&:values).flatten!
      Hash[k, v]
    end
  end
end
