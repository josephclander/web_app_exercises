require 'post'
require 'post_manager'

describe PostManager do
 it 'adds new post' do
    manager = PostManager.new
    new_post = Post.new('Test post', 'Hello!', ['coding'])

    manager.add_post(new_post)

    expect(manager.all_posts).to include(new_post)
  end

  it 'returns all posts by tag' do

  end

  it 'adds new post' do
    manager = PostManager.new
    new_post_coding = Post.new('Test post', 'Hello!', ['coding'])
    new_post_music = Post.new('Another test post', 'Hi!', ['music'])

    manager.add_post(new_post_coding)
    manager.add_post(new_post_music)

    expect(manager.all_posts_by_tag('coding')).to include(new_post_coding)
    expect(manager.all_posts_by_tag('coding')).to_not include(new_post_music)
  end
end

def create_test_post_with_tags(title, tags)
  PostManager.instance.add_post(
    Post.new(title, "I'm just a test post. Nothing much to say really.", tags)
  )
end