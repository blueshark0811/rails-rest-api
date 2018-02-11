import React from 'react';
import Media from 'react-media';

import ModalHeader from './components/ModalHeader';
import ModalBody from './components/ModalBody';
import ModalFooter from './components/ModalFooter';
import ModalInner from './components/ModalInner';

class Modal extends React.Component {
  constructor() {
    super();
    // we will use this state for setting the overflow value of the body
    this.state = {
      bodyHidden: true
    };
  }

  componentWillMount() {
    // before we initiall render our component, set this first.
    document.getElementsByTagName('body')[0].style.overflow = 'hidden';
  }

  handleCloseModal = e => {
    // we want to go back if the div modal or modalButtonClose is clicked.
    e.stopPropagation();
    if (
      e.target.className === 'Modal' ||
      e.target.className === 'ModalButtonClose'
    ) {
      this.props.history.goBack();
    }

    // update the state of bodyHidden to true stating to remove the hidden overflow of the body
    this.setState({
      bodyHidden: false
    });
  };

  componentWillUpdate(nextProps, nextState) {
    // if not equal, the state gets updated , we need to remove the overflow hidden
    if (this.state.bodyHidden !== nextState.bodyHidden) {
      document.getElementsByTagName('body')[0].style.overflow = 'auto';
    }
  }

  render() {
    // style modal
    const modalStyle = {
      width: '100%',
      height: '100vh',
      backgroundColor: 'rgba(53, 53, 53, 0.53)',
      position: 'fixed',
      zIndex: 5,
      top: 0,
      overflowY: 'auto',
      overflowX: 'hidden'
    };
    return (
      <Media query="(max-width: 767px)">
        {matches =>
          matches ? (
            <div
              onClick={this.handleCloseModal}
              className="Modal"
              style={modalStyle}
            >
              <ModalInner>
                <ModalHeader handleCloseModal={this.handleCloseModal} />
                <ModalBody />
                <ModalFooter />
              </ModalInner>
            </div>
          ) : (
            <div
              onClick={this.handleCloseModal}
              className="Modal"
              style={{
                ...modalStyle,
                left: 0
              }}
            >
              <ModalInner>
                <ModalHeader handleCloseModal={this.handleCloseModal} />
                <ModalBody />
                <ModalFooter />
              </ModalInner>
            </div>
          )}
      </Media>
    );
  }
}

export default Modal;
