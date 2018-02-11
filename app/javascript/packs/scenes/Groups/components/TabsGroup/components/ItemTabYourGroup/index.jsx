import React from 'react';
import PropTypes from 'prop-types';
import { isEmpty } from 'ramda';

import NoGroups from './components/NoGroups';
import ListYourGroup from './components/ListYourGroup';

const ItemTabYourGroup = ({ yourGroups }) => {
  if (isEmpty(yourGroups)) {
    return <NoGroups />;
  }

  // else
  return <ListYourGroup yourGroups={yourGroups} />;
};

ItemTabYourGroup.propTypes = {
  yourGroups: PropTypes.arrayOf(PropTypes.object).isRequired
};

export default ItemTabYourGroup;
