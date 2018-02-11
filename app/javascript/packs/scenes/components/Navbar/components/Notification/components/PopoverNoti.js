import React from 'react';
import PropTypes from 'prop-types';

import IconBell from 'react-icons/lib/fa/bell';
import Popover from 'base_components/Popover';

const PopoverNoti = ({ notiRowData }) => {
  return <Popover buttonIcon={<IconBell />} popoverContent={notiRowData} />;
};

PopoverNoti.propTypes = {
  notiRowData: PropTypes.element
};

export default PopoverNoti;
