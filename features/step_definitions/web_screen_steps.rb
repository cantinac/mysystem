module WithinHelpers
  def with_scope(locator)
    locator ? within(locator) { yield } : yield
  end
end
World(WithinHelpers)

When /^(?:|I )am on (.+)$/ do |page_name|
  visit path_to(page_name)
end

Then /^(?:|I )should see "([^\"]*)" on the screen(?: within "([^\"]*)")?$/ do |text, selector|
  with_scope(selector) do
    page.find(:xpath, "//*[contains(text(), '#{text}')]").should be_visible
  end
end