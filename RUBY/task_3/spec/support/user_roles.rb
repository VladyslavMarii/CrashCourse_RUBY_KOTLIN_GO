module UserRoles
    USERS = {
      standard_user: {
        username: 'standard_user',
        password: 'secret_sauce',
        description: 'Standard user with normal access'
      },
      locked_user: {
        username: 'locked_out_user',
        password: 'secret_sauce',
        description: 'Locked out user'
      },
      error_user: {
        username: 'error_user',
        password: 'secret_sauce',
        description: 'Error user'
      }
    }.freeze
end