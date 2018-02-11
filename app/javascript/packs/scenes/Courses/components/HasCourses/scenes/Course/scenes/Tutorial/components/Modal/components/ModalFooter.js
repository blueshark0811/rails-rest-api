import React from 'react';

import ModalBox from './ModalBox';
import SlideControl from './SlideControl';

const ModalFooter = () => {
  return (
    <ModalBox
      style={{
        justifyContent: 'space-between'
      }}
    >
      <SlideControl
        handleClick={_ => console.log('prev')}
        text="Previous"
        arrow="&#60;"
      />
      <SlideControl
        handleClick={_ => console.log('next')}
        text="Next"
        arrow="&#62;"
      />
    </ModalBox>
  );
};

export default ModalFooter;
