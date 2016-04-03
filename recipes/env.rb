bash "Add a usefull prompt inside .bashrc" do
       code <<-EOH
yum_package 'Development Tools' do
  action                     :install
end

rm -rf /root/ruby

mkdir /root/ruby
cd /root/ruby

wget http://ftp.ruby-lang.org/pub/ruby/1.9/ruby-1.9.3-p194.tar.gz

tar xvzf ruby-1.9.3-p194.tar.gz
cd ruby-1.9.3-p194
./configure
make
make install

rm -rf /root/rubygem
mkdir /root/rubygem
cd /root/rubygem

wget http://production.cf.rubygems.org/rubygems/rubygems-1.8.24.tgz
tar xvf rubygems-1.8.24.tgz
cd rubygems-1.8.24
ruby setup.rb
        EOH
rvm use 1.9.3 --default

      end


gem_package 'zabcon' do
  action :install
end
