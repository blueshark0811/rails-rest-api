import React from 'react';
import PropTypes from 'prop-types';

import TableFiles from 'base_components/TableFiles';

const ItemTableTutorialFiles = ({ files }) => <TableFiles files={files} />;

ItemTableTutorialFiles.propTypes = {
  files: PropTypes.array.isRequired
};

export default ItemTableTutorialFiles;
