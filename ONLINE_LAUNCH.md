# 🌐 Cursive Terminal - Online Launch Guide

Complete guide to launching the Cursive Terminal website and online theme selector.

---

## 🚀 Quick Launch

The project includes a **fully functional website** ready to deploy:

### What's Included

**Website Files** (`website/` directory):
- ✅ **index.html** - Professional landing page with:
  - Hero section with animated terminal
  - Features showcase
  - Font gallery
  - Download section
  - Responsive design

- ✅ **src/styles.css** (17KB) - Beautiful styling with:
  - Victor Mono font integration
  - Smooth animations
  - Mobile-responsive design
  - Dark/light theme support

- ✅ **src/script.js** (14KB) - Interactive features:
  - Terminal animation
  - Smooth scrolling
  - Theme switcher
  - Copy-to-clipboard functionality

**Interactive Tools**:
- ✅ **scripts/theme-selector-web.html** (35KB) - Web-based theme browser
- ✅ **scripts/theme-demo-template.html** (11KB) - Theme preview template

---

## 🎯 Deployment Options

### Option 1: GitHub Pages (Recommended)

**Automatic Deployment** - Already configured!

The project includes `.github/workflows/deploy-pages.yml` which automatically deploys to GitHub Pages when you push to main.

**Setup Steps**:

1. **Enable GitHub Pages**:
   ```
   Go to: Settings → Pages
   Source: GitHub Actions
   ```

2. **Merge your documentation PR** (or push to main)

3. **Website will be live at**:
   ```
   https://midnightnow.github.io/Cursive-Terminal/
   ```

**Alternative Manual Setup**:
```
Settings → Pages → Source: Deploy from a branch
Branch: main
Folder: /website
Save
```

### Option 2: Local Preview

**Already Running!** 🎉

A local server is currently serving the website at:
```
http://localhost:8080
```

To start it manually later:
```bash
cd website
python3 -m http.server 8080
```

Then open: http://localhost:8080

### Option 3: Netlify/Vercel (Free Hosting)

**Netlify**:
1. Connect your GitHub repo
2. Build directory: `website`
3. Deploy!

**Vercel**:
1. Import Git repository
2. Root directory: `website`
3. Deploy!

### Option 4: Custom Domain

After GitHub Pages deployment, you can add a custom domain:

1. Add `CNAME` file to `website/` directory:
   ```bash
   echo "cursiveterminal.com" > website/CNAME
   ```

2. Configure DNS:
   ```
   Type: CNAME
   Name: www
   Value: midnightnow.github.io

   Type: A
   Name: @
   Value: 185.199.108.153 (GitHub Pages IP)
   ```

---

## 📋 Website Features

### Landing Page (index.html)

**Hero Section**:
- Animated terminal window
- Real-time typing effect
- Beautiful cursive text demo
- Download CTA buttons

**Features Section**:
- 5+ cursive fonts showcase
- Perfect monospace alignment
- Syntax highlighting examples
- Color theme previews

**Stats Section**:
- Download count
- GitHub stars
- Community size

**Download Section**:
- Quick start commands
- Installation instructions
- Platform support info

**Footer**:
- Social links
- Documentation links
- Sponsor buttons

### Theme Selector (theme-selector-web.html)

**Interactive Features**:
- Browse all 33 themes
- Filter by category:
  - Dark (9 themes)
  - Light (6 themes)
  - Colorful (6 themes)
  - Business (6 themes)
  - Accessible (6 themes)
- Live preview
- Copy theme code
- Font style toggle
- Search functionality

---

## 🎨 Customization

### Update Website Content

**Edit Hero Section**:
```html
<!-- website/index.html line 71 -->
<h1 class="hero-title">
    Your Custom Title
</h1>
```

**Update Stats**:
```html
<!-- website/index.html line 95 -->
<div class="stat-number">50K+</div>
```

**Change Colors**:
```css
/* website/src/styles.css */
:root {
    --primary-color: #your-color;
    --accent-color: #your-accent;
}
```

### Add Analytics

**Google Analytics**:
```html
<!-- Add to website/index.html <head> -->
<script async src="https://www.googletagmanager.com/gtag/js?id=GA_MEASUREMENT_ID"></script>
```

**Plausible** (already configured):
```html
<!-- Line 34 in index.html -->
<script defer data-domain="cursiveterminal.com" src="https://plausible.io/js/script.js"></script>
```

---

## 🔗 URLs After Deployment

**Main Website**:
```
https://midnightnow.github.io/Cursive-Terminal/
```

**Theme Selector**:
```
https://midnightnow.github.io/Cursive-Terminal/../scripts/theme-selector-web.html
```

**Direct Access**:
- Home: `/`
- Features: `/#features`
- Fonts: `/#fonts`
- Download: `/#download`
- Docs: `/#docs`

---

## 📊 Monitoring & Analytics

### GitHub Pages Stats

Check deployment status:
```
Actions tab → Deploy Website to GitHub Pages
```

### Traffic Analytics

1. **GitHub Insights**:
   - Repository → Insights → Traffic
   - Page views, unique visitors
   - Referrer sources

2. **Plausible Analytics** (if configured):
   - Privacy-friendly
   - GDPR compliant
   - Real-time stats

---

## 🚀 Launch Checklist

- [ ] Enable GitHub Pages in repository settings
- [ ] Deploy website (automatic or manual)
- [ ] Test website at GitHub Pages URL
- [ ] Verify theme selector works
- [ ] Check mobile responsiveness
- [ ] Test all links and buttons
- [ ] Add custom domain (optional)
- [ ] Configure analytics (optional)
- [ ] Share website URL on social media
- [ ] Add website link to README

---

## 📱 Mobile Support

The website is fully responsive:
- ✅ Mobile-first design
- ✅ Touch-friendly controls
- ✅ Adaptive layouts
- ✅ Optimized images
- ✅ Fast loading

Test on:
- [ ] iPhone
- [ ] Android
- [ ] Tablet
- [ ] Desktop (various sizes)

---

## 🎯 SEO & Social Media

### Open Graph Tags

Already configured for:
- Facebook sharing
- LinkedIn sharing
- Slack previews

### Twitter Cards

Optimized for:
- Twitter sharing
- Rich previews
- Large images

### Meta Description

```html
<meta name="description" content="Beautiful cursive fonts for developers. Transform your terminal into elegant, flowing script while maintaining perfect code alignment.">
```

---

## 🔧 Troubleshooting

### Website Not Deploying

**Check**:
1. GitHub Actions workflow status
2. Pages settings enabled
3. Workflow file exists: `.github/workflows/deploy-pages.yml`
4. Main branch has latest commits

**Fix**:
```bash
# Re-trigger deployment
git commit --allow-empty -m "Trigger Pages deployment"
git push origin main
```

### 404 Error

**Cause**: GitHub Pages not finding files

**Fix**:
1. Check deployment directory is `website/`
2. Verify `index.html` exists in `website/`
3. Add `.nojekyll` file to `website/`

### CSS/JS Not Loading

**Cause**: Incorrect paths

**Fix**: Use relative paths:
```html
<!-- Correct -->
<link rel="stylesheet" href="src/styles.css">

<!-- Incorrect -->
<link rel="stylesheet" href="/src/styles.css">
```

### Theme Selector Not Working

**Check**:
1. JavaScript enabled in browser
2. Console for errors (F12)
3. File paths correct

---

## 📈 Post-Launch Promotion

### Update README

Add website link:
```markdown
**🌐 [Visit Our Website](https://midnightnow.github.io/Cursive-Terminal/)**
```

### Social Media Announcements

**Twitter/X**:
```
🚀 Cursive Terminal website is LIVE!

✨ Interactive theme selector
🎨 Browse all 33 themes
📱 Fully responsive
🆓 100% free & open source

Check it out: https://midnightnow.github.io/Cursive-Terminal/

#terminal #webdev #opensource
```

**Reddit** (r/webdev, r/opensource):
```
Just launched the Cursive Terminal website!

Features:
- Interactive theme browser (33 themes)
- Live code previews
- 5+ cursive font showcases
- One-click installation

Link: https://midnightnow.github.io/Cursive-Terminal/
GitHub: https://github.com/midnightnow/Cursive-Terminal
```

**Product Hunt**:
- Submit as new product
- Category: Developer Tools
- Include screenshots
- Link to website and GitHub

---

## 🎊 Success Metrics

### Week 1 Goals
- [ ] 1,000 unique visitors
- [ ] 100 GitHub stars
- [ ] 50 downloads
- [ ] 10 social shares

### Month 1 Goals
- [ ] 5,000 unique visitors
- [ ] 500 GitHub stars
- [ ] 200 downloads
- [ ] 50 social shares
- [ ] First contributor PR

---

## 🌐 Live Website Preview

**Local Preview** (Currently Running):
```
http://localhost:8080
```

**GitHub Pages** (After deployment):
```
https://midnightnow.github.io/Cursive-Terminal/
```

**Custom Domain** (If configured):
```
https://cursiveterminal.com
```

---

## 📝 Next Steps

1. **Immediate**:
   - [ ] Enable GitHub Pages
   - [ ] Push to main branch
   - [ ] Verify deployment
   - [ ] Test website live

2. **Short Term**:
   - [ ] Add website link to README
   - [ ] Share on social media
   - [ ] Submit to directories
   - [ ] Configure analytics

3. **Long Term**:
   - [ ] Custom domain
   - [ ] CDN optimization
   - [ ] A/B testing
   - [ ] User feedback forms

---

**🚀 Your website is ready to launch!**

The local preview is running at: http://localhost:8080

To deploy to GitHub Pages, just enable it in your repository settings or merge your PR to main.

*Created: October 24, 2024*
