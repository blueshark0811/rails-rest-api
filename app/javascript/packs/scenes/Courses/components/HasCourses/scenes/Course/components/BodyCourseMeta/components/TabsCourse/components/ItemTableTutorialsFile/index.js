import React from 'react';
import PropTypes from 'prop-types';

import TableFiles from 'base_components/TableFiles';

const ItemTableTutorialsFile = ({ files }) => <TableFiles files={files} />;

ItemTableTutorialsFile.propTypes = {
  files: PropTypes.array
};

export default ItemTableTutorialsFile;
