// Cursive Terminal Website JavaScript

// ===== Utility Functions =====
function debounce(func, wait) {
    let timeout;
    return function executedFunction(...args) {
        const later = () => {
            clearTimeout(timeout);
            func(...args);
        };
        clearTimeout(timeout);
        timeout = setTimeout(later, wait);
    };
}

function throttle(func, limit) {
    let inThrottle;
    return function() {
        const args = arguments;
        const context = this;
        if (!inThrottle) {
            func.apply(context, args);
            inThrottle = true;
            setTimeout(() => inThrottle = false, limit);
        }
    }
}

// ===== Copy to Clipboard Functionality =====
function copyToClipboard(button) {
    const codeBlock = button.previousElementSibling;
    const text = codeBlock.textContent;
    
    navigator.clipboard.writeText(text).then(() => {
        const originalText = button.textContent;
        button.textContent = 'Copied!';
        button.style.background = '#4ECDC4';
        
        setTimeout(() => {
            button.textContent = originalText;
            button.style.background = '#6B5B95';
        }, 2000);
    }).catch(err => {
        console.error('Failed to copy text: ', err);
        // Fallback for older browsers
        const textArea = document.createElement('textarea');
        textArea.value = text;
        document.body.appendChild(textArea);
        textArea.select();
        document.execCommand('copy');
        document.body.removeChild(textArea);
        
        button.textContent = 'Copied!';
        setTimeout(() => {
            button.textContent = 'Copy';
        }, 2000);
    });
}

// ===== Smooth Scrolling for Navigation Links =====
function initSmoothScrolling() {
    const navLinks = document.querySelectorAll('a[href^="#"]');
    
    navLinks.forEach(link => {
        link.addEventListener('click', (e) => {
            e.preventDefault();
            
            const targetId = link.getAttribute('href');
            const targetSection = document.querySelector(targetId);
            
            if (targetSection) {
                const headerOffset = 80;
                const elementPosition = targetSection.getBoundingClientRect().top;
                const offsetPosition = elementPosition + window.pageYOffset - headerOffset;
                
                window.scrollTo({
                    top: offsetPosition,
                    behavior: 'smooth'
                });
            }
        });
    });
}

// ===== Terminal Animation =====
function initTerminalAnimation() {
    const terminalLines = document.querySelectorAll('.terminal-line');
    const cursor = document.querySelector('.terminal-cursor');
    
    // Hide all lines initially
    terminalLines.forEach(line => {
        line.style.opacity = '0';
        line.style.transform = 'translateY(10px)';
    });
    
    // Animate lines in sequence
    function animateLines() {
        terminalLines.forEach((line, index) => {
            setTimeout(() => {
                line.style.transition = 'all 0.5s ease';
                line.style.opacity = '1';
                line.style.transform = 'translateY(0)';
            }, index * 800);
        });
    }
    
    // Start animation when hero is visible
    const hero = document.querySelector('.hero');
    const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                setTimeout(animateLines, 1000);
                observer.unobserve(entry.target);
            }
        });
    });
    
    observer.observe(hero);
}

// ===== Header Scroll Effect =====
function initHeaderScrollEffect() {
    const header = document.querySelector('.header');
    let lastScrollY = window.scrollY;
    
    const handleScroll = throttle(() => {
        const currentScrollY = window.scrollY;
        
        if (currentScrollY > 100) {
            header.classList.add('scrolled');
        } else {
            header.classList.remove('scrolled');
        }
        
        // Hide/show header based on scroll direction
        if (currentScrollY > lastScrollY && currentScrollY > 200) {
            header.style.transform = 'translateY(-100%)';
        } else {
            header.style.transform = 'translateY(0)';
        }
        
        lastScrollY = currentScrollY;
    }, 10);
    
    window.addEventListener('scroll', handleScroll);
}

// ===== Installation Steps Animation =====
function initInstallationSteps() {
    const steps = document.querySelectorAll('.step');
    const downloadSection = document.querySelector('.download');
    
    const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                // Animate steps in sequence
                steps.forEach((step, index) => {
                    setTimeout(() => {
                        // Remove active class from all steps
                        steps.forEach(s => s.classList.remove('active'));
                        // Add active class to current step
                        step.classList.add('active');
                    }, index * 1000);
                });
                
                observer.unobserve(entry.target);
            }
        });
    }, { threshold: 0.5 });
    
    if (downloadSection) {
        observer.observe(downloadSection);
    }
}

// ===== Font Card Hover Effects =====
function initFontCardEffects() {
    const fontCards = document.querySelectorAll('.font-card');
    
    fontCards.forEach(card => {
        card.addEventListener('mouseenter', () => {
            const sample = card.querySelector('.font-sample');
            if (sample) {
                // Add some dynamic content or animation
                sample.style.transform = 'scale(1.02)';
            }
        });
        
        card.addEventListener('mouseleave', () => {
            const sample = card.querySelector('.font-sample');
            if (sample) {
                sample.style.transform = 'scale(1)';
            }
        });
    });
}

// ===== Scroll-triggered Animations =====
function initScrollAnimations() {
    const animatedElements = document.querySelectorAll('.feature-card, .font-card, .community-card');
    
    const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.style.opacity = '1';
                entry.target.style.transform = 'translateY(0)';
                observer.unobserve(entry.target);
            }
        });
    }, { threshold: 0.1 });
    
    animatedElements.forEach(element => {
        element.style.opacity = '0';
        element.style.transform = 'translateY(30px)';
        element.style.transition = 'all 0.6s ease';
        observer.observe(element);
    });
}

// ===== Stats Counter Animation =====
function initStatsCounter() {
    const stats = document.querySelectorAll('.stat-number');
    
    function animateValue(element, start, end, duration) {
        let startTimestamp = null;
        const step = (timestamp) => {
            if (!startTimestamp) startTimestamp = timestamp;
            const progress = Math.min((timestamp - startTimestamp) / duration, 1);
            const current = Math.floor(progress * (end - start) + start);
            
            if (element.textContent.includes('K')) {
                element.textContent = current + 'K+';
            } else if (element.textContent.includes('★')) {
                element.textContent = (start + progress * (end - start)).toFixed(1) + '★';
            } else {
                element.textContent = current + '+';
            }
            
            if (progress < 1) {
                window.requestAnimationFrame(step);
            }
        };
        window.requestAnimationFrame(step);
    }
    
    const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                const stat = entry.target;
                const text = stat.textContent;
                
                if (text.includes('50K')) {
                    animateValue(stat, 0, 50, 2000);
                } else if (text.includes('5+')) {
                    animateValue(stat, 0, 5, 1500);
                } else if (text.includes('4.9★')) {
                    animateValue(stat, 0, 4.9, 2500);
                }
                
                observer.unobserve(entry.target);
            }
        });
    }, { threshold: 0.5 });
    
    stats.forEach(stat => observer.observe(stat));
}

// ===== Dynamic Terminal Typing Effect =====
function initTypingEffect() {
    const typingElements = document.querySelectorAll('.cursive-text');
    
    typingElements.forEach(element => {
        const text = element.textContent;
        element.textContent = '';
        element.style.borderRight = '2px solid #FFD700';
        
        let i = 0;
        const typeWriter = () => {
            if (i < text.length) {
                element.textContent += text.charAt(i);
                i++;
                setTimeout(typeWriter, 100);
            } else {
                element.style.borderRight = 'none';
            }
        };
        
        // Start typing when element is visible
        const observer = new IntersectionObserver((entries) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    setTimeout(typeWriter, 500);
                    observer.unobserve(entry.target);
                }
            });
        });
        
        observer.observe(element);
    });
}

// ===== Mobile Menu Toggle =====
function initMobileMenu() {
    // Add mobile menu button if screen is small
    const nav = document.querySelector('.nav');
    const navLinks = document.querySelector('.nav-links');
    
    if (window.innerWidth <= 768) {
        const menuButton = document.createElement('button');
        menuButton.innerHTML = '☰';
        menuButton.className = 'mobile-menu-btn';
        menuButton.style.cssText = `
            background: none;
            border: none;
            color: var(--text-light);
            font-size: 1.5rem;
            cursor: pointer;
            display: block;
        `;
        
        nav.appendChild(menuButton);
        
        menuButton.addEventListener('click', () => {
            navLinks.style.display = navLinks.style.display === 'flex' ? 'none' : 'flex';
        });
    }
}

// ===== Performance Monitoring =====
function initPerformanceMonitoring() {
    // Log performance metrics
    window.addEventListener('load', () => {
        const navigation = performance.getEntriesByType('navigation')[0];
        const loadTime = navigation.loadEventEnd - navigation.loadEventStart;
        
        console.log(`Page load time: ${loadTime}ms`);
        
        // Send to analytics if available
        if (window.plausible) {
            window.plausible('Page Load', { 
                props: { 
                    loadTime: Math.round(loadTime),
                    userAgent: navigator.userAgent.includes('Mobile') ? 'Mobile' : 'Desktop'
                }
            });
        }
    });
}

// ===== Error Handling =====
function initErrorHandling() {
    window.addEventListener('error', (e) => {
        console.error('JavaScript error:', e.error);
        
        // Send to error tracking if available
        if (window.plausible) {
            window.plausible('JavaScript Error', {
                props: {
                    error: e.error.message,
                    filename: e.filename,
                    line: e.lineno
                }
            });
        }
    });
}

// ===== Analytics Event Tracking =====
function initAnalytics() {
    // Track button clicks
    document.querySelectorAll('.btn').forEach(button => {
        button.addEventListener('click', (e) => {
            const buttonText = e.target.textContent.trim();
            
            if (window.plausible) {
                window.plausible('Button Click', {
                    props: { button: buttonText }
                });
            }
        });
    });
    
    // Track external links
    document.querySelectorAll('a[href^="http"]').forEach(link => {
        link.addEventListener('click', (e) => {
            const url = e.target.href;
            
            if (window.plausible) {
                window.plausible('External Link', {
                    props: { url: url }
                });
            }
        });
    });
    
    // Track copy code clicks
    document.querySelectorAll('.copy-btn').forEach(button => {
        button.addEventListener('click', () => {
            if (window.plausible) {
                window.plausible('Code Copied');
            }
        });
    });
}

// ===== Main Initialization =====
function init() {
    // Wait for DOM to be fully loaded
    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', init);
        return;
    }
    
    try {
        // Initialize all features
        initSmoothScrolling();
        initTerminalAnimation();
        initHeaderScrollEffect();
        initInstallationSteps();
        initFontCardEffects();
        initScrollAnimations();
        initStatsCounter();
        initTypingEffect();
        initMobileMenu();
        initPerformanceMonitoring();
        initErrorHandling();
        initAnalytics();
        
        console.log('Cursive Terminal website initialized successfully!');
        
    } catch (error) {
        console.error('Error initializing website:', error);
    }
}

// ===== Service Worker Registration =====
if ('serviceWorker' in navigator) {
    window.addEventListener('load', () => {
        navigator.serviceWorker.register('/sw.js')
            .then((registration) => {
                console.log('SW registered: ', registration);
            })
            .catch((registrationError) => {
                console.log('SW registration failed: ', registrationError);
            });
    });
}

// Start the application
init();