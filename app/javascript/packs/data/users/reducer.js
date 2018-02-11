import { GET_USERS } from './actionTypes';

const initialUsers = {
  '23423423424jj324': {
    _id: '23423423424jj324',
    name: 'Irish Jane',
    type: 'Admin',
    username: 'irishjane',
    password: '123456'
  },
  '234238sdjf34234j': {
    _id: '234238sdjf34234j',
    name: 'Drish Cual',
    type: 'Student',
    username: 'drish',
    password: '123456'
  },
  '234234nj23lkj423': {
    _id: '234234nj23lkj423',
    name: 'Dennis Martin',
    type: 'Teacher',
    username: 'drish',
    password: '123456'
  }
};

// reducers for managing users
const users = (state = initialUsers, action) => {
  switch (action.type) {
    case GET_USERS: {
      return state;
    }
    default: {
      return state;
    }
  }
};

export default users;
