require 'spec_helper'
describe Puppet::Type.type(:rabbitmq_binding) do
  before do
    @binding = Puppet::Type.type(:rabbitmq_binding).new(
      name: 'foo@blub@bar',
      destination_type: :queue
    )
  end
  it 'accepts an queue name' do
    @binding[:name] = 'dan@dude@pl'
    expect(@binding[:name]).to eq('dan@dude@pl')
  end
  it 'requires a name' do
    expect do
      Puppet::Type.type(:rabbitmq_binding).new({})
    end.to raise_error(Puppet::Error, 'Title or name must be provided')
  end
  it 'errors when missing source' do
    expect do
      Puppet::Type.type(:rabbitmq_binding).new(
        name: 'test binding',
        destination: 'foobar'
      )
    end.to raise_error(Puppet::Error, %r{Source and destination must both be defined})
  end
  it 'errors when missing destination' do
    expect do
      Puppet::Type.type(:rabbitmq_binding).new(
        name: 'test binding',
        source: 'foobar'
      )
    end.to raise_error(Puppet::Error, %r{Source and destination must both be defined})
  end
  it 'accepts an binding destination_type' do
    @binding[:destination_type] = :exchange
    expect(@binding[:destination_type]).to eq(:exchange)
  end
  it 'accepts a user' do
    @binding[:user] = :root
    expect(@binding[:user]).to eq(:root)
  end
  it 'accepts a password' do
    @binding[:password] = :PaSsw0rD
    expect(@binding[:password]).to eq(:PaSsw0rD)
  end
end
