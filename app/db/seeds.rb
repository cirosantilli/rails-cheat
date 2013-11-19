# Create initial data only for a single environment.
if Rails.env.development?
    Model0.create string_col: 'aa', integer_col: 123
    Model0.create string_col: 'ab', integer_col: 456

    Model1.create string_col: '0'
    Model1.create string_col: '1'
    Model1.create string_col: '2'
    Model1.create string_col: '3'
end
