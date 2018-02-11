import React from 'react';
import PropTypes from 'prop-types';

// for button
import Button from 'base_components/Button';
import IconDownload from 'react-icons/lib/fa/download';

import IconArrowRight from 'react-icons/lib/fa/angle-right';
import IconArrowDown from 'react-icons/lib/fa/angle-down';
import Interactive from 'react-interactive';

const TutorialTaskPanelHeader = ({
  isReadingGroup,
  isPanelOpen,
  category,
  title,
  handleTogglePanel
}) => {
  const {
    container,
    headerCategory,
    headerTitle,
    icon,
    downloadButton
  } = tutorialTaskPanelHeaderStyle;
  return (
    <div style={container} className="TutorialTaskPanelHeader">
      <div>
        <p style={headerCategory}>{category}</p>
        <Interactive
          as="p"
          hover={{ color: '#338FFC' }}
          onClick={handleTogglePanel}
          style={headerTitle}
        >
          {title}
        </Interactive>
        {isReadingGroup && (
          <Button style={downloadButton} text="Download">
            <span>
              <IconDownload style={downloadButton.span} />
            </span>
          </Button>
        )}
      </div>
      {isPanelOpen ? (
        <span>
          <IconArrowDown style={icon} onClick={handleTogglePanel} />
        </span>
      ) : (
        <span>
          <IconArrowRight style={icon} onClick={handleTogglePanel} />
        </span>
      )}
    </div>
  );
};

TutorialTaskPanelHeader.propTypes = {
  isReadingGroup: PropTypes.bool.isRequired,
  isPanelOpen: PropTypes.bool.isRequired,
  category: PropTypes.string.isRequired,
  title: PropTypes.string.isRequired,
  handleTogglePanel: PropTypes.func.isRequired
};

const tutorialTaskPanelHeaderStyle = {
  container: {
    padding: '1em',
    display: 'flex',
    justifyContent: 'space-between',
    alignItems: 'center'
  },
  headerCategory: {
    color: '#9FA6AD',
    marginBottom: '0.8em'
  },
  headerTitle: {
    fontSize: 16,
    color: '#111111',
    marginBottom: 0,
    maxWidth: 600,
    transition: 'all 300ms ease-in',
    cursor: 'pointer'
  },
  icon: {
    fontSize: '1.2rem',
    color: '#6c6c6c',
    cursor: 'pointer'
  },
  downloadButton: {
    background: '#ffffff',
    border: '1px solid #d4d4d4',
    color: '#c9c9c9',
    marginTop: '0.6em',
    span: {
      marginLeft: '0.5em'
    }
  }
};

export default TutorialTaskPanelHeader;
